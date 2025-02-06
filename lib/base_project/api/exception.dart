sealed class Result<S> {
  const Result();

  static const isOk = 0;
  static const isError = 1;
  static const isHttp = 2;
  static const isNotConnect = -1;
  static const isTimeOut = -2;
  static const isDueServer = -3;

}

final class Success<S> extends Result<S> {
  const Success(this.value);
  final S value;
}

final class Failure<S> extends Result<S> {
  const Failure(this.errorCode);
  final int errorCode;
}