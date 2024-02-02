import 'dart:async';

import 'package:flutter/material.dart';
import 'package:v12_like/quote/quote_model.dart';
import 'package:v12_like/quote/quote_service.dart';

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

  late final List<int> _scores;
  late final TextEditingController _controller;

  final Duration _duration = const Duration(seconds: 1);

  @override
  void initState() {
    super.initState();

    _scores = <int>[];
    _controller = TextEditingController();

    unawaited(_start());
  }

  Future<void> _start() async {
    try {
      final Quote randomQuote = await QuoteService.getRandomQuote();

      setState(() {
        _quote = randomQuote;
        _controller.addListener(_controllerListener);
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

  void _controllerListener() {
    if (_timer != null && _controller.text == _quote.content) {
      setState(() {
        _scores.add(_timer!.tick);
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

  void _debug() {
    _controller.text = _quote.content;
  }

  Future<void> _restart() async {
    setState(() {
      _isLoading = true;
      _isError = false;

      _timer?.cancel();
      _timer = null;

      _controller
        ..removeListener(_controllerListener)
        ..clear();
    });

    await _start();
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
      theme: ThemeData(),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ElevatedButton(
                                onPressed: _debug,
                                child: const Text('Debug'),
                              ),
                              ElevatedButton(
                                onPressed: _restart,
                                child: const Text('Restart'),
                              ),
                            ],
                          ),
                          Text(_timer?.tick.toString() ?? '0'),
                          Text(_quote.content),
                          TextField(
                            controller: _controller,
                            enabled: _controller.text != _quote.content,
                            decoration: const InputDecoration(
                              hintText: 'Enter a quote',
                            ),
                          ),
                          ..._scores.map((int score) => Text(score.toString())),
                        ],
                      ),
          ),
        ),
      ),
    );
  }
}
