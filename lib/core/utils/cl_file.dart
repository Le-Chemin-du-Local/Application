import 'package:freezed_annotation/freezed_annotation.dart';

part 'cl_file.freezed.dart';
part 'cl_file.g.dart';

@freezed
@immutable
class ClFile with _$ClFile {
  const factory ClFile({
    @JsonKey(name: "name") required String filename,
    @JsonKey(name: "content") String? base64content
  }) = _ClFile;

  factory ClFile.fromJson(Map<String, dynamic> json) => _$ClFileFromJson(json);
}