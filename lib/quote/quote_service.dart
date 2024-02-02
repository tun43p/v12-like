import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:v12_like/quote/quote_model.dart';

/// A service class for quotes.
class QuoteService {
  static const String _randomQuoteAPIUrl = 'https://api.quotable.io/random';

  /// Get a random quote from the API.
  static Future<Quote> getRandomQuote() async {
    try {
      final http.Response response =
          await http.get(Uri.parse(_randomQuoteAPIUrl));

      if (response.statusCode != HttpStatus.ok) {
        throw Exception('Failed to get a random quote');
      }
      final Quote quote = Quote.fromJson(json.decode(response.body));

      return quote;
    } catch (error) {
      rethrow;
    }
  }
}
