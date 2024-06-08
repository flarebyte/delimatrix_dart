library delimatrix_dart;

sealed class DxResult<T> {
  const DxResult();

  bool get isSuccess => this is DxSuccess<T>;
  bool get isFailure => this is DxFailure;

  T? get value => this is DxSuccess<T> ? (this as DxSuccess<T>).value : null;
  DxFailure? get error => this is DxFailure ? (this as DxFailure) : null;

  DxResult<U> map<U>(U Function(T value) f) {
    if (this is DxSuccess<T>) {
      return DxSuccess<U>(f((this as DxSuccess<T>).value));
    } else {
      final failure = this as DxFailure;
      return DxFailure(failure.id, failure.message);
    }
  }
}

final class DxSuccess<T> extends DxResult<T> { 
  @override
  final T value;

  const DxSuccess(this.value);
}

final class DxFailure extends DxResult<Never> {
  final String id;
  final String message;

  const DxFailure(this.id, this.message);
}
