import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

class BaseView<T extends Store> extends StatefulWidget {

  final Widget Function(BuildContext context, T value) onPageBuilder;
  final T viewModel;
  final Function(T model)? onModelReady;
  final VoidCallback? onDispose;

  BaseView({
    Key? key,
    required this.viewModel,
    this.onModelReady,
    this.onDispose,
    required this.onPageBuilder,
  }) : super(key: key);

  @override
  _BaseViewState createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  @override
  void initState() {
    super.initState();

    if (widget.onModelReady != null)
      return widget.onModelReady!(widget.viewModel);
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.onDispose != null) return widget.onDispose!();
  }

  @override
  Widget build(BuildContext context) {
    return widget.onPageBuilder(context, widget.viewModel);
  }
}
