library delimatrix_dart;

/// Result that can either be a success or failure.
sealed class DxResult<T> {
  const DxResult();

  /// A successful 
  bool get isSuccess => this is DxSuccess<T>;

  /// A failure
  bool get isFailure => this is DxFailure;

  T? get value => this is DxSuccess<T> ? (this as DxSuccess<T>).value : null;
  DxFailure? get error => this is DxFailure ? (this as DxFailure) : null;

  /// Returns a new [DxResult] by applying the given function to the contained
  /// value if it is a success or returning the same error otherwise.
  DxResult<U> map<U>(U Function(T value) f) {
    if (this is DxSuccess<T>) {
      return DxSuccess<U>(f((this as DxSuccess<T>).value));
    } else {
      final failure = this as DxFailure;
      return DxFailure(failure.id, failure.message);
    }
  }

 /// Returns a new [DxResult] by applying a validation function
  DxResult<T> validate(bool Function(T value) validator, String errorId, String errorMessage) {
    if (this is DxSuccess<T>) {
      if (validator((this as DxSuccess<T>).value)) {
        return this;
      } else {
        return DxFailure(errorId, errorMessage);
      }
    } else {
      return this;
    }
  }
}

/// A successful result that contains a value of type [T].
final class DxSuccess<T> extends DxResult<T> { 
  @override
  final T value;

  const DxSuccess(this.value);
}

/// A failure result that contains an error ID and a message.
final class DxFailure extends DxResult<Never> {
  final String id;
  final String message;

  const DxFailure(this.id, this.message);
}
