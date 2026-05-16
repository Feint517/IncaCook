// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_vehicle_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DriverVehicleRequest _$DriverVehicleRequestFromJson(
  Map<String, dynamic> json,
) => _DriverVehicleRequest(
  vehicleType: $enumDecode(_$DriverVehicleTypeEnumMap, json['vehicleType']),
  dateOfBirth: json['dateOfBirth'] as String?,
);

Map<String, dynamic> _$DriverVehicleRequestToJson(
  _DriverVehicleRequest instance,
) => <String, dynamic>{
  'vehicleType': _$DriverVehicleTypeEnumMap[instance.vehicleType]!,
  'dateOfBirth': ?instance.dateOfBirth,
};

const _$DriverVehicleTypeEnumMap = {
  DriverVehicleType.bicycle: 'BICYCLE',
  DriverVehicleType.scooter: 'SCOOTER',
  DriverVehicleType.car: 'CAR',
};
