# Driver Operating Zones - Testing Guide

## Overview

Driver zones allow drivers to select their preferred operating areas during signup. Zones are:
- **Admin-managed** via backoffice API endpoints
- **Fetched from backend** at driver signup
- **Currently NOT used** for delivery filtering (open dispatch: all drivers see all jobs)
- **Future-ready** for zone-based matching when scaling

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    Data Flow                                │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  BACKEND Zone Table     →   GET /v1/zones (public)          │
│  - id (ULID)            →   Returns active zones             │
│  - name                 →   Frontend shows as chips          │
│  - city                 →   Driver selects zones             │
│  - isActive             →   PUT /v1/drivers/me/zones         │
│  - displayOrder         →   Zones saved to DriverZone table │
│                                                              │
│  CURRENT STATE: Zones stored but NOT used for filtering    │
│  (All drivers see all SEARCHING deliveries)                 │
└─────────────────────────────────────────────────────────────┘
```

## API Endpoints

### Public Endpoint (No Authentication)

```http
GET /v1/zones
```

**Response:**
```json
[
  {
    "id": "01HJX...XYZ",
    "name": "Paris 11e",
    "city": "Paris"
  },
  {
    "id": "01HJX...ABC",
    "name": "Lyon Centre",
    "city": "Lyon"
  }
]
```

### Admin Endpoints (Require Admin Auth)

```http
GET    /v1/zones/all       # All zones including inactive
GET    /v1/zones/:id       # Single zone details
POST   /v1/zones           # Create new zone
PUT    /v1/zones/:id       # Update zone
DELETE /v1/zones/:id       # Deactivate zone (soft delete)
```

**Create Zone Request:**
```json
{
  "name": "Paris 12e",
  "city": "Paris",
  "isActive": true,
  "displayOrder": 4
}
```

## Testing Checklist

### Backend Testing

#### 1. Zone Table Migration
```bash
cd IncaCook-Server
npx prisma migrate deploy
```
**Verify:**
- Zone table exists in database
- DriverZone foreign key references Zone table
- Indexes created: `Zone_name_key`, `Zone_isActive_displayOrder_idx`, `Zone_city_idx`

#### 2. Seed Zones
```bash
cd IncaCook-Server
npx ts-node scripts/seed-zones.ts
```
**Verify:**
- 15 default zones created
- Check in database: `SELECT * FROM "Zone";`

#### 3. Public API Test
```bash
# Get active zones (no auth required)
curl https://api.incacook.fr/v1/zones
```
**Expected:** Array of active zones with id, name, city

#### 4. Admin API Test
```bash
# Create new zone (requires admin token)
curl -X POST https://api.incacook.fr/v1/zones \
  -H "Authorization: Bearer <admin-token>" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Nice Centre",
    "city": "Nice",
    "isActive": true,
    "displayOrder": 80
  }'

# Get all zones (including inactive)
curl https://api.incacook.fr/v1/zones/all \
  -H "Authorization: Bearer <admin-token>"

# Deactivate zone
curl -X DELETE https://api.incacook.fr/v1/zones/<zone-id> \
  -H "Authorization: Bearer <admin-token>"
```

### Frontend Testing

#### 1. Driver Signup - Zone Selection

**Test Steps:**
1. Start new driver signup flow
2. Navigate to zone selection step
3. **Verify:** Zones are fetched from `GET /v1/zones`
4. **Verify:** Predefined zones display as selectable chips
5. **Verify:** Search filters zones locally (no network call)
6. Select 2-3 zones
7. **Verify:** Selected zones show as chips with delete button
8. Continue to next step

**Expected Result:**
- Zones loaded successfully from API
- UI matches backend zone list
- Selected zones persisted to `controller.operatingZones`

#### 2. Zone Persistence

**Test Steps:**
1. Complete driver signup with selected zones
2. Verify in database:
```sql
SELECT * FROM "DriverZone" WHERE "userId" = '<driver-user-id>';
```
**Expected:** Selected zones stored with correct zoneId references

#### 3. Zone Display in Profile

**Test Steps:**
1. As driver, view profile
2. **Verify:** Selected operating zones are displayed

#### 4. Backend Filtering (Future - NOT YET IMPLEMENTED)

**⚠️ CURRENT BEHAVIOR:**
- All online drivers see ALL SEARCHING deliveries
- Zones are stored but NOT used for filtering
- Matching is distance-based only (driver → seller pickup)

**Future Test (when implemented):**
1. Driver A selects only "Paris 11e"
2. Driver B selects only "Lyon Centre"
3. Create delivery in Paris 11e area
4. **Expected:** Driver A sees the delivery, Driver B does not

## Database Queries for Verification

```sql
-- Check all zones
SELECT * FROM "Zone" ORDER BY "displayOrder", "name";

-- Check active zones only
SELECT id, name, city FROM "Zone" WHERE "isActive" = true;

-- Count zones per city
SELECT city, COUNT(*) FROM "Zone" WHERE "isActive" = true GROUP BY city;

-- Check driver zones
SELECT dz."userId", z.name, z.city
FROM "DriverZone" dz
JOIN "Zone" z ON dz."zoneId" = z.id
ORDER BY dz."userId", z."displayOrder";

-- Find drivers operating in a specific city
SELECT DISTINCT u.id, u.email, u."firstName", u."lastName"
FROM "User" u
JOIN "DriverProfile" dp ON dp."userId" = u.id
JOIN "DriverZone" dz ON dz."userId" = dp."userId"
JOIN "Zone" z ON dz."zoneId" = z.id
WHERE z.city = 'Paris' AND dp."isOnline" = true;
```

## Common Issues & Solutions

### Issue: Zone table doesn't exist
**Solution:** Run migrations: `npx prisma migrate deploy`

### Issue: No zones returned from API
**Solution:** Run seed script: `npx ts-node scripts/seed-zones.ts`

### Issue: Driver zones not saving
**Solution:** Check `PUT /v1/drivers/me/zones` endpoint is working

### Issue: Frontend shows hardcoded zones
**Solution:** Frontend should fetch from `GET /v1/zones`. Check network tab for API call.

## Future Enhancements

1. **Zone-based Delivery Filtering**
   - Filter `listAvailable` by driver zones
   - Use city matching first, then polygon matching

2. **Zone Management UI**
   - Admin panel to add/remove zones
   - Visual map editor for zone boundaries

3. **Smart Zone Recommendations**
   - Suggest zones based on driver location
   - Show delivery density per zone

## Migration Notes

When implementing zone-based filtering:

1. **Phase 1:** City-level matching (simple)
   ```sql
   WHERE EXISTS (
     SELECT 1 FROM "DriverZone" dz
     JOIN "Zone" z ON dz."zoneId" = z."id"
     JOIN "Address" a ON a.id = o."dropoffAddressId"
     WHERE dz."userId" = $driverId
     AND a.city = z.city
   )
   ```

2. **Phase 2:** Polygon matching (precise)
   ```sql
   WHERE ST_Within(
     (SELECT point FROM "Address" WHERE id = o."dropoffAddressId"),
     (SELECT polygon FROM "Zone" WHERE id IN (
       SELECT "zoneId" FROM "DriverZone" WHERE "userId" = $driverId
     ))
   )
   ```

## Notes

- Zones are **UI-only** until zone-based matching is implemented
- Current matching: **Open dispatch** (all drivers see all jobs)
- Zones ARE saved to database for future use
- Admin can manage zones via API without deployment
