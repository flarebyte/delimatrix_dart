library delimatrix_dart;
import 'dx_result.dart';

abstract class DxTransformer<T, U> {
  DxResult<U> transform(DxResult<T> input);

  DxTransformer<T, V> chain<V>(DxTransformer<U, V> nextTransformer) {
    return _ChainedDxTransformer(this, nextTransformer);
  }
}

class _ChainedDxTransformer<T, U, V> extends DxTransformer<T, V> {
  final DxTransformer<T, U> first;
  final DxTransformer<U, V> second;

  _ChainedDxTransformer(this.first, this.second);

  @override
  DxResult<V> transform(DxResult<T> input) {
    final intermediateResult = first.transform(input);
    return second.transform(intermediateResult);
  }
}
