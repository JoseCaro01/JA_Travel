/*Method to validate the email */
extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

/*Method to validate if all characters are numbers */
extension NumberValidator on String {
  bool isNumber() {
    return RegExp(r"^[0-9]", caseSensitive: false).hasMatch(this);
  }
}

/*Method to validate the password */
extension PasswordValidator on String {
  bool isValidPassword() {
    return RegExp(r"^(?=\w*\d)(?=\w*[A-Z])(?=\w*[a-z])\S{8,}$").hasMatch(this);
  }
}
