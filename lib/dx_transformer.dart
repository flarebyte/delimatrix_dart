library delimatrix_dart;

import 'dx_result.dart';

/// A transformer that takes a [DxResult] of type [T], and produces one of type [U].
abstract class DxTransformer<T, U> {
  DxResult<U> transform(DxResult<T> input);

  /// Returns a new transformer that chains this one with another.
  DxTransformer<T, V> chain<V>(DxTransformer<U, V> nextTransformer) {
    return _ChainedDxTransformer(this, nextTransformer);
  }
}

/// A transformer that takes a [DxResult] of type [T], and produces one of type [U].
class _ChainedDxTransformer<T, U, V> extends DxTransformer<T, V> {
  final DxTransformer<T, U> first;
  final DxTransformer<U, V> second;

  _ChainedDxTransformer(this.first, this.second);

  /// Returns a new transformer that chains this one with another.
  @override
  DxResult<V> transform(DxResult<T> input) {
    final intermediateResult = first.transform(input);
    return second.transform(intermediateResult);
  }
}
