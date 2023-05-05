import 'package:freezed_annotation/freezed_annotation.dart';

import 'media.dart';

part 'article.freezed.dart';

part 'article.g.dart';

@Freezed()
class Article with _$Article {
  const factory Article({
    required String section,
    required String subsection,
    required String title,
    required String abstract,
    required String url,
    required String uri,
    required String byline,
    required String item_type,
    required String updated_date,
    required String created_date,
    required String published_date,
    required String material_type_facet,
    required String kicker,
    required List<String> des_facet,
    required List<String> org_facet,
    required List<String> per_facet,
    required List<String> geo_facet,
    required List<Media> multimedia,
    required String short_url,
  }) = _Article;

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
}
