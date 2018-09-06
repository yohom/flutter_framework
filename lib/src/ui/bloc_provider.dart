import 'package:flutter/material.dart';
import 'package:framework/framework.dart';

class BlocProvider<B extends Bloc> extends StatefulWidget {
  final Widget child;
  final B bloc;

  BlocProvider({
    Key key,
    @required this.child,
    @required this.bloc,
  }) : super(key: key);

  @override
  _BlocProviderState createState() => _BlocProviderState();

  static B of<B extends Bloc>(BuildContext context, [bool rebuild = true]) {
    return (rebuild
            ? context.inheritFromWidgetOfExactType(_BlocProvider)
                as _BlocProvider
            : context.ancestorWidgetOfExactType(_BlocProvider) as _BlocProvider)
        .bloc;
  }
}

class _BlocProviderState extends State<BlocProvider> {
  @override
  Widget build(BuildContext context) {
    return _BlocProvider(bloc: widget.bloc, child: widget.child);
  }

  @override
  void dispose() {
    widget.bloc.close();
    super.dispose();
  }
}

class _BlocProvider<B extends Bloc> extends InheritedWidget {
  final B bloc;

  _BlocProvider({
    Key key,
    @required this.bloc,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_BlocProvider old) => bloc != old.bloc;
}
