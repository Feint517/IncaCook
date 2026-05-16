// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kyc_document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KycDocument _$KycDocumentFromJson(Map<String, dynamic> json) => _KycDocument(
  id: json['id'] as String,
  type: $enumDecode(_$KycDocumentTypeEnumMap, json['type']),
  fileUrl: json['fileUrl'] as String,
  reviewState: $enumDecode(_$KycReviewStateEnumMap, json['reviewState']),
  rejectionReason: json['rejectionReason'] as String?,
  submittedAt: json['submittedAt'] as String,
  reviewedAt: json['reviewedAt'] as String?,
  metadata: json['metadata'] == null
      ? null
      : KycDocumentMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
);

Map<String, dynamic> _$KycDocumentToJson(_KycDocument instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$KycDocumentTypeEnumMap[instance.type]!,
      'fileUrl': instance.fileUrl,
      'reviewState': _$KycReviewStateEnumMap[instance.reviewState]!,
      'rejectionReason': ?instance.rejectionReason,
      'submittedAt': instance.submittedAt,
      'reviewedAt': ?instance.reviewedAt,
      'metadata': ?instance.metadata?.toJson(),
    };

const _$KycDocumentTypeEnumMap = {
  KycDocumentType.idFront: 'ID_FRONT',
  KycDocumentType.idBack: 'ID_BACK',
  KycDocumentType.selfie: 'SELFIE',
  KycDocumentType.drivingLicense: 'DRIVING_LICENSE',
  KycDocumentType.carteGrise: 'CARTE_GRISE',
  KycDocumentType.insurance: 'INSURANCE',
};

const _$KycReviewStateEnumMap = {
  KycReviewState.pending: 'PENDING',
  KycReviewState.approved: 'APPROVED',
  KycReviewState.rejected: 'REJECTED',
};

_KycDocumentMetadata _$KycDocumentMetadataFromJson(Map<String, dynamic> json) =>
    _KycDocumentMetadata(
      idDocumentType: $enumDecodeNullable(
        _$IdDocumentTypeEnumMap,
        json['idDocumentType'],
      ),
    );

Map<String, dynamic> _$KycDocumentMetadataToJson(
  _KycDocumentMetadata instance,
) => <String, dynamic>{
  'idDocumentType': ?_$IdDocumentTypeEnumMap[instance.idDocumentType],
};

const _$IdDocumentTypeEnumMap = {
  IdDocumentType.carteIdentite: 'CARTE_IDENTITE',
  IdDocumentType.passeport: 'PASSEPORT',
  IdDocumentType.titreSejour: 'TITRE_SEJOUR',
};
