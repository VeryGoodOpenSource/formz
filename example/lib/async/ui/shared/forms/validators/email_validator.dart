import 'package:example/async/data/repositories/email_repository.dart';
import 'package:example/async/ui/shared/forms/inputs/email_input.dart';
import 'package:example/async/ui/shared/forms/validation_errors/email_errors.dart';
import 'package:formz/formz.dart';
import 'package:regexpattern/regexpattern.dart';

const _kEmailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';

class EmailValidator
    extends AsyncFormzInputValidator<Email, String, EmailValidationError> {
  const EmailValidator({
    required EmailRepository emailRepository,
  }) : _emailRepository = emailRepository;

  final EmailRepository _emailRepository;

  @override
  bool canValidate(Email input) {
    if (input.validationStatus.isValidated) {
      return true;
    }
    final validFormat = RegVal.hasMatch(
      input.value,
      _kEmailPattern,
    );
    return validFormat;
  }

  @override
  Future<EmailValidationError?> validate(Email input) async {
    if (input.isRequired && input.value.isEmpty) {
      return const EmailValidationError.required();
    }

    final validFormat = RegVal.hasMatch(
      input.value,
      _kEmailPattern,
    );
    if (!validFormat) {
      return const EmailValidationError.invalidFormat();
    }

    final alreadyExist = await _emailRepository.findByAddress(input.value);
    if (alreadyExist) {
      return const EmailValidationError.alreadyExists();
    }

    return null;
  }
}
