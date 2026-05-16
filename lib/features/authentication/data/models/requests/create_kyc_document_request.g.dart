// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_kyc_document_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateKycDocumentRequest _$CreateKycDocumentRequestFromJson(
  Map<String, dynamic> json,
) => _CreateKycDocumentRequest(
  type: $enumDecode(_$KycDocumentTypeEnumMap, json['type']),
  fileUrl: json['fileUrl'] as String,
  idDocumentType: $enumDecodeNullable(
    _$IdDocumentTypeEnumMap,
    json['idDocumentType'],
  ),
);

Map<String, dynamic> _$CreateKycDocumentRequestToJson(
  _CreateKycDocumentRequest instance,
) => <String, dynamic>{
  'type': _$KycDocumentTypeEnumMap[instance.type]!,
  'fileUrl': instance.fileUrl,
  'idDocumentType': ?_$IdDocumentTypeEnumMap[instance.idDocumentType],
};

const _$KycDocumentTypeEnumMap = {
  KycDocumentType.idFront: 'ID_FRONT',
  KycDocumentType.idBack: 'ID_BACK',
  KycDocumentType.selfie: 'SELFIE',
  KycDocumentType.drivingLicense: 'DRIVING_LICENSE',
  KycDocumentType.carteGrise: 'CARTE_GRISE',
  KycDocumentType.insurance: 'INSURANCE',
};

const _$IdDocumentTypeEnumMap = {
  IdDocumentType.carteIdentite: 'CARTE_IDENTITE',
  IdDocumentType.passeport: 'PASSEPORT',
  IdDocumentType.titreSejour: 'TITRE_SEJOUR',
};
