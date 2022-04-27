extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

extension OneDigits on String {
  bool isOneDigits() {
    return RegExp("(?:[^0-9]*[0-9]){1}").hasMatch(this);
  }
}

extension OneCapital on String {
  bool isOneCapital() {
    return RegExp("(?:[^A-Z]*[A-Z]){1}").hasMatch(this);
  }
}

extension OneSmall on String {
  bool isOneSmall() {
    return RegExp("(?:[^a-z]*[a-z]){1}").hasMatch(this);
  }
}
