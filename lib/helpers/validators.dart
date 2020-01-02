class Validators {
  static String validateString(String value, String field) {
    return value.trim().length == 0 ? '    $field is required' : null;
  }

  static String validateMaxLength(String value, int length, String field) {
    return value.trim().length > length ? '    $field is required' : null;
  }

  static String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return !regex.hasMatch(value) ? '    Enter Valid Email' : null;
  }

  static String validatePassword(String value) {
    Pattern pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) {
      return '    Please enter password';
    } else {
      return !regex.hasMatch(value) ? '    Enter valid password' : null;
    }
  }
}
