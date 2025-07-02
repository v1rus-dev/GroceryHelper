import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef TypedBuilder<S extends Object> = Widget Function(BuildContext context, S state);

class SafeContentBuilder<B extends BlocBase<T>, T extends Object, S extends T> extends StatefulWidget {
  final bool Function(T previous, T current)? buildWhen;
  final TypedBuilder<S> builder;

  const SafeContentBuilder({super.key, this.buildWhen, required this.builder});

  @override
  State<SafeContentBuilder<B, T, S>> createState() => _SafeContentBuilderState<B, T, S>();
}

class _SafeContentBuilderState<B extends BlocBase<T>, T extends Object, S extends T>
    extends State<SafeContentBuilder<B, T, S>> {
  S? _lastValidState;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, T>(
      buildWhen: widget.buildWhen,
      builder: (context, state) {
        if (state is S) {
          _lastValidState = state;
        }

        if (_lastValidState != null) {
          return widget.builder(context, _lastValidState as S);
        }

        return const SizedBox.shrink(); // либо initial loading
      },
    );
  }
}
