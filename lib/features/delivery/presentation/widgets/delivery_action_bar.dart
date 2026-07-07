import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import 'package:incacook/core/constants/sizes.dart';
import 'package:incacook/core/utils/geo/distance.dart';
import 'package:incacook/features/delivery/controllers/delivery_route_controller.dart';
import 'package:incacook/features/delivery/presentation/widgets/job_stage_actions.dart';

/// Compact, always-visible action strip shown while a Driver has an Active
/// delivery. Pinned in the bottom sheet's header (above the scrollable body) so
/// the driver's next step — stage title, distance, and the primary CTA — is one
/// tap away even with the sheet collapsed and the map full-screen. Dragging the
/// sheet up still reveals the full [JobLifecycleCard] (contacts, fallbacks,
/// report) for detail. The CTA runs the same [runStageCta] as the full card.
class DeliveryActionBar extends StatelessWidget {
  const DeliveryActionBar({super.key});

  static const double height = 68;

  @override
  Widget build(BuildContext context) {
    final route = DeliveryRouteController.instance;
    return Obx(() {
      final job = route.currentJob.value;
      final stage = route.currentStage.value;
      if (job == null || stage == null) return const SizedBox.shrink();

      final scheme = Theme.of(context).colorScheme;
      final textTheme = Theme.of(context).textTheme;
      final labels = stageLabels(stage);

      // Distance to the current target (pickup or dropoff); null until both the
      // driver fix and the destination are known.
      final destination = route.currentDestination;
      final origin = route.currentDriverPosition;
      final distanceKm = (destination != null && origin != null)
          ? greatCircleDistance(origin, destination) / 1000
          : null;

      return Container(
        height: height,
        decoration: BoxDecoration(
          color: scheme.surfaceContainerLow,
          border: Border(
            top: BorderSide(color: scheme.outline.withValues(alpha: 0.12)),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: scheme.primary.withValues(alpha: 0.14),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(labels.icon, color: scheme.primary, size: 18),
            ),
            const Gap(AppSizes.sm),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    labels.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleSmall?.copyWith(
                      color: scheme.onSurface,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  if (distanceKm != null) ...[
                    const Gap(1),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Iconsax.location5,
                          size: 12,
                          color: scheme.onSurfaceVariant,
                        ),
                        const Gap(4),
                        Text(
                          '${NumberFormat('0.0', 'fr_FR').format(distanceKm)} km',
                          style: textTheme.labelSmall?.copyWith(
                            color: scheme.onSurfaceVariant,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            const Gap(AppSizes.sm),
            FilledButton(
              onPressed: () => runStageCta(context, route, stage),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.md,
                  vertical: AppSizes.sm + 2,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                textStyle: textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              child: Text(labels.cta),
            ),
          ],
        ),
      );
    });
  }
}
