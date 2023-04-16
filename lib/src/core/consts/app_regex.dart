abstract class AppRegexp {
  static const email = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static const dddCellPhone = r"^\([1-9]{2}\)\ 9 \d{4}-\d{4}";
  static const space = r"\s\b|\b\s";
  static const truckCode = r"^[A-Z]{2}[1-9]{3}";
  static const letters = r"[A-Z-a-z]";
  static const lettersLow = r"[a-z]";
  static const truckCodeUpp = r"[A-Z]";
  static const digits = r"\d";
  static const numbers = r"^[0-9]*$";
  static const caractereMask = r"[^\#^\d]";
  static const onlyDigits = r"[^\d]";
  static const multiplesSpaces = r"\s+\b|\b\s";
  static const cep = "[0-9]{5}-[0-9]{3}";
  static const validateSecurityCode = "[0-9]{6}";
}
