import 'dart:async';

import 'package:flutter/material.dart';
import 'package:v12_like/core/extensions/theme_extension.dart';
import 'package:v12_like/core/theme/dark_theme.dart';
import 'package:v12_like/quote/quote_model.dart';
import 'package:v12_like/quote/quote_service.dart';
import 'package:v12_like/widgets/text_field_widget.dart';

void main() {
  runApp(const Main());
}

/// This is the main application widget.
class Main extends StatefulWidget {
  /// This is the constructor for the main application widget.
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  Timer? _timer;

  bool _isError = false;
  bool _isLoading = true;

  late Quote _quote;

  late final List<Duration> _scores;
  late final TextEditingController _controller;

  final Duration _duration = const Duration(milliseconds: 1);
  final int _maxQuoteLength = 80;

  @override
  void initState() {
    super.initState();

    _scores = <Duration>[];
    _controller = TextEditingController();

    unawaited(_start());
  }

  Future<void> _start() async {
    try {
      Quote randomQuote = await QuoteService.getRandomQuote();
      // Temps que la longueur de la citation est supérieure à 80 caractères
      while (randomQuote.length > _maxQuoteLength) {
        randomQuote = await QuoteService.getRandomQuote();
      }

      setState(() {
        _quote = randomQuote;
        _controller.addListener(_listener);
        _isLoading = false;
      });
    } catch (error, stackTrace) {
      setState(() {
        _isError = true;
        _isLoading = false;
      });

      debugPrint(error.toString());
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  void _listener() {
    if (_timer != null && _controller.text == _quote.content) {
      setState(() {
        _scores.add(Duration(milliseconds: _timer!.tick));
        _timer?.cancel();
      });
    } else if (_controller.text.isNotEmpty &&
        (_timer == null || !_timer!.isActive)) {
      _timer = Timer.periodic(_duration, (Timer timer) {
        setState(() {
          _timer = timer;
        });
      });
    }
  }

  Future<void> _restart() async {
    setState(() {
      _isLoading = true;
      _isError = false;

      _timer?.cancel();
      _timer = null;

      _controller
        ..removeListener(_listener)
        ..clear();
    });

    await _start();
  }

  void _debug() {
    _controller.text = _quote.content;
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'V12 Like',
      theme: darkTheme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('V12 Like'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: _isError
                ? const Text('An error occurred. Please reload the page.')
                : _isLoading
                    ? const CircularProgressIndicator()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            Duration(milliseconds: _timer?.tick ?? 0)
                                .toString(),
                            style: context.theme.fonts.displayLarge,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 32),
                            child: Text(
                              _quote.content,
                              style: context.theme.fonts.displayMedium,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          TextFieldWidget(
                            controller: _controller,
                            hint: 'Type fast!',
                            disabled: _controller.text == _quote.content,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 32),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ElevatedButton(
                                  onPressed: _debug,
                                  child: const Text('Debug'),
                                ),
                                const SizedBox(width: 16),
                                ElevatedButton(
                                  onPressed: _restart,
                                  child: const Text('Restart'),
                                ),
                              ],
                            ),
                          ),
                          ..._scores.map(
                            (Duration score) => Text(score.toString()),
                          ),
                        ],
                      ),
          ),
        ),
      ),
    );
  }
}
