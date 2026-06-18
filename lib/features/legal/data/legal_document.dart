/// A published legal document (CGU or CGV) fetched from the backend
/// (`GET /v1/legal-documents/active`). The mobile app shows the active
/// version's [content]; [version] is what publish/purchase acceptance is
/// recorded against server-side.
class LegalDocument {
  const LegalDocument({
    required this.kind,
    required this.version,
    required this.title,
    required this.content,
    this.publishedAt,
  });

  /// 'CGU' or 'CGV'.
  final String kind;
  final String version;
  final String title;
  final String content;
  final DateTime? publishedAt;

  bool get isCgu => kind.toUpperCase() == 'CGU';
  bool get isCgv => kind.toUpperCase() == 'CGV';

  factory LegalDocument.fromJson(Map<String, dynamic> json) {
    return LegalDocument(
      kind: (json['kind'] as String? ?? '').toUpperCase(),
      version: json['version'] as String? ?? '',
      title: json['title'] as String? ?? '',
      content: json['content'] as String? ?? '',
      publishedAt: DateTime.tryParse(json['publishedAt'] as String? ?? ''),
    );
  }
}
