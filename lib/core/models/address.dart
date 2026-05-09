import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:iconsax/iconsax.dart';
import 'package:incacook/core/constants/text_strings.dart';
import 'package:incacook/core/services/map/models/map_route.dart';

part 'address.freezed.dart';
part 'address.g.dart';

/// Saved-address category used to label home / work / other entries.
/// Null on one-off addresses captured during signup or ad-hoc checkout.
enum SavedAddressType {
  home(label: AppTexts.addressTypeHome, icon: Iconsax.home_2),
  work(label: AppTexts.addressTypeWork, icon: Iconsax.briefcase),
  other(label: AppTexts.addressTypeOther, icon: Iconsax.location);

  const SavedAddressType({required this.label, required this.icon});

  final String label;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final IconData icon;
}

/// A user-supplied or geocoded address. Same shape across the signup flow,
/// the saved-addresses sheet, and checkout.
///
/// - [id] is null for in-flight pickers; the backend assigns one on save.
/// - [type] / [customLabel] only matter for saved addresses.
/// - [inRange] is a transient UI flag (out-of-range for the active seller's
///   delivery radius). It is not part of the persisted shape — set by the
///   list builder when displaying. Excluded from JSON.
@freezed
abstract class Address with _$Address {
  const Address._();

  const factory Address({
    required String fullAddress,
    required String city,
    required String postalCode,
    MapPoint? coordinate,
    String? id,
    SavedAddressType? type,
    String? customLabel,
    String? apartment,
    String? floor,
    String? digicode,
    String? deliveryNotes,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default(true)
    bool inRange,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  String get line1 => fullAddress;
  String get line2 => '$postalCode $city'.trim();
  String get label => customLabel ?? type?.label ?? line1;
}
