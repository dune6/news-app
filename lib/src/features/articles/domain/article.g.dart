// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Article _$$_ArticleFromJson(Map<String, dynamic> json) => _$_Article(
      section: json['section'] as String,
      subsection: json['subsection'] as String,
      title: json['title'] as String,
      abstract: json['abstract'] as String,
      url: json['url'] as String,
      uri: json['uri'] as String,
      byline: json['byline'] as String,
      item_type: json['item_type'] as String,
      updated_date: json['updated_date'] as String,
      created_date: json['created_date'] as String,
      published_date: json['published_date'] as String,
      material_type_facet: json['material_type_facet'] as String,
      kicker: json['kicker'] as String,
      des_facet:
          (json['des_facet'] as List<dynamic>).map((e) => e as String).toList(),
      org_facet:
          (json['org_facet'] as List<dynamic>).map((e) => e as String).toList(),
      per_facet:
          (json['per_facet'] as List<dynamic>).map((e) => e as String).toList(),
      geo_facet:
          (json['geo_facet'] as List<dynamic>).map((e) => e as String).toList(),
      multimedia: (json['multimedia'] as List<dynamic>)
          .map((e) => Media.fromJson(e as Map<String, dynamic>))
          .toList(),
      short_url: json['short_url'] as String,
    );

Map<String, dynamic> _$$_ArticleToJson(_$_Article instance) =>
    <String, dynamic>{
      'section': instance.section,
      'subsection': instance.subsection,
      'title': instance.title,
      'abstract': instance.abstract,
      'url': instance.url,
      'uri': instance.uri,
      'byline': instance.byline,
      'item_type': instance.item_type,
      'updated_date': instance.updated_date,
      'created_date': instance.created_date,
      'published_date': instance.published_date,
      'material_type_facet': instance.material_type_facet,
      'kicker': instance.kicker,
      'des_facet': instance.des_facet,
      'org_facet': instance.org_facet,
      'per_facet': instance.per_facet,
      'geo_facet': instance.geo_facet,
      'multimedia': instance.multimedia,
      'short_url': instance.short_url,
    };
