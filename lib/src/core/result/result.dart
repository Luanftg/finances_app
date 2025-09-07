abstract final class Result<T extends Object> {
  const Result();

  factory Result.sucess(T value) = Sucess._;
  factory Result.failure(Exception exception) = Failure._;
}

final class Sucess<T extends Object> extends Result<T> {
  final T value;

  Sucess._(this.value);
}

final class Failure<T extends Object> extends Result<T> {
  Failure._(this.error);

  Exception error;
}

extension ResultExtension on Object {
  Result sucess() => Result.sucess(this);
}

extension ResultException on Exception {
  Result failure() => Result.failure(this);
}

extension ResultCasting<T extends Object> on Result<T> {
  Sucess<T> get asSucess => this as Sucess<T>;
  Failure<T> get asFailure => this as Failure<T>;
}
