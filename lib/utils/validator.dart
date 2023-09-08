class Validator {
  static String? required(String? value) {
    return value != null && value.isNotEmpty
        ? null
        : 'Поле не должно быть пустым';
  }

  static String? maxLength(String? value, int maxLength) {
    return value != null && value.length == maxLength
        ? null
        : 'Введите только $maxLength цифр';
  }
}
