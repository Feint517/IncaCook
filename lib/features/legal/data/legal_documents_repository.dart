import 'package:get/get.dart';

import 'package:incacook/core/constants/api_constants.dart';
import 'package:incacook/core/network/api_client.dart';
import 'package:incacook/features/legal/data/legal_document.dart';

/// Repository for the public legal-documents API
/// (`GET /v1/legal-documents/active`). Reuses the shared [ApiClient]. Returns
/// the currently-active CGU/CGV documents; the caller falls back to the bundled
/// local text when the list is empty or the request fails.
class LegalDocumentsRepository extends GetxService {
  LegalDocumentsRepository({ApiClient? api}) : _api = api ?? Get.find<ApiClient>();

  final ApiClient _api;

  /// `GET /v1/legal-documents/active` — the active CGU + CGV documents.
  Future<List<LegalDocument>> fetchActive() async {
    final result = await _api.get<List<LegalDocument>>(
      '${ApiConstants.apiPrefix}/legal-documents/active',
      decoder: (json) => (json! as List<dynamic>)
          .map((e) => LegalDocument.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
    return result.data;
  }
}
