import 'package:form_validator/form_validator.dart';

extension ValidatorExtension on ValidationBuilder {
  ValidationBuilder username() {
    return regExp(
        RegExp(r'^(?=[a-zA-Z0-9._]{8,20}$)(?!.*[_.]{2})[^_.].*[^_.]$'),
        "Between 8-20 characters long");
  }

  ValidationBuilder password() {
    return regExp(
      RegExp(
          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$'),
      "Minimum eight characters, at least one uppercase letter, one lowercase letter, one number and one special character",
    );
  }

  ValidationBuilder name() {
    return regExp(
      RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| @ | ))*[A-Za-z]+\.?\s*$"),
      "",
    );
  }

  ValidationBuilder numeric() {
    return regExp(
      RegExp(r"^([0-9]*)$"),
      "Should only contains [0-9]",
    );
  }
}
