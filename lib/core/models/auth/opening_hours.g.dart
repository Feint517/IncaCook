// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'opening_hours.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OpeningHoursRow _$OpeningHoursRowFromJson(Map<String, dynamic> json) =>
    _OpeningHoursRow(
      dayOfWeek: $enumDecode(_$DayOfWeekEnumMap, json['dayOfWeek']),
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
    );

Map<String, dynamic> _$OpeningHoursRowToJson(_OpeningHoursRow instance) =>
    <String, dynamic>{
      'dayOfWeek': _$DayOfWeekEnumMap[instance.dayOfWeek]!,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
    };

const _$DayOfWeekEnumMap = {
  DayOfWeek.monday: 'MONDAY',
  DayOfWeek.tuesday: 'TUESDAY',
  DayOfWeek.wednesday: 'WEDNESDAY',
  DayOfWeek.thursday: 'THURSDAY',
  DayOfWeek.friday: 'FRIDAY',
  DayOfWeek.saturday: 'SATURDAY',
  DayOfWeek.sunday: 'SUNDAY',
};
