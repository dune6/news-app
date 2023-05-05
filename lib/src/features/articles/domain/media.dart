import 'package:freezed_annotation/freezed_annotation.dart';

part 'media.freezed.dart';

part 'media.g.dart';

@Freezed()
class Media with _$Media {
  const factory Media({
    required String url,
    required String format,
    required int height,
    required int width,
    required String type,
    required String subtype,
    required String caption,
    required String copyright,
  }) = _Media;

  factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);
}
