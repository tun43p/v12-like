import 'package:freezed_annotation/freezed_annotation.dart';

part 'quote_model.freezed.dart';
part 'quote_model.g.dart';

/// A model class for a quote.
@freezed
class Quote with _$Quote {
  /// The constructor for the quote model class.
  const factory Quote({
    // ignore: invalid_annotation_target, this is a bug in the freezed package
    @JsonKey(name: '_id') required String id,
    required String content,
    required String author,
    required List<String> tags,
    required String authorSlug,
    required int length,
    required String dateAdded,
    required String dateModified,
  }) = _Quote;

  /// Convert a JSON object to a [Quote] instance.
  factory Quote.fromJson(Map<String, dynamic> json) => _$QuoteFromJson(json);
}
