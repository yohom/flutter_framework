import 'package:decorated_flutter/decorated_flutter.dart';
import 'package:flutter/material.dart';

class Countdown extends StatefulWidget {
  const Countdown({
    Key? key,
    required this.initialData,
    this.interval = const Duration(seconds: 1),
    required this.builder,
    this.onPressed,
  }) : super(key: key);

  final int initialData;
  final Duration interval;
  final Widget Function(BuildContext, int) builder;
  final ContextCallback? onPressed;

  @override
  _CountdownState createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {
  late Stream<int> _countStream;

  @override
  void initState() {
    super.initState();
    _countStream = Stream.periodic(
      widget.interval,
      (count) => widget.initialData - 1 - count,
    ).take(widget.initialData);
  }

  @override
  Widget build(BuildContext context) {
    Widget result = StreamBuilder<int>(
      initialData: widget.initialData,
      stream: _countStream,
      builder: (context, snapshot) {
        return widget.builder(context, snapshot.data!);
      },
    );

    if (widget.onPressed != null) {
      result = GestureDetector(
        onTap: () => widget.onPressed!(context),
        child: result,
      );
    }

    return result;
  }
}
