class Result<T, E> {
  Result({this.data, this.error});
  final T? data;
  final E? error;

  bool get isSuccess => error == null;

  @override
  String toString() {
    return 'Result(data: $data, error: $error)';
  }
}
