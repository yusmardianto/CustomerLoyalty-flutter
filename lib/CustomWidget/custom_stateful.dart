import 'package:flutter/material.dart';

typedef Disposer = void Function();

class CustomStatefulBuilder extends StatefulWidget {
  const CustomStatefulBuilder({
    Key key,
    @required this.builder,
    @required this.dispose,
  }) : assert(builder != null),
        super(key: key);

  final StatefulWidgetBuilder builder;
  final Disposer dispose;

  @override
  _CustomStatefulBuilderState createState() => _CustomStatefulBuilderState();
}

class _CustomStatefulBuilderState extends State<CustomStatefulBuilder> {
  @override
  Widget build(BuildContext context) => widget.builder(context, setState);

  @override
  void dispose() {
    super.dispose();
    widget.dispose();
  }
}