extension StatusCodeCheckSuccess on int? {
  bool isSuccess() => this != null && this! >= 200 && this! <= 299;
}
