library formz;

import 'package:meta/meta.dart';

/// Enum representing the submission status of a form.
enum FormzSubmissionStatus {
  /// The form has not yet been submitted.
  initial,

  /// The form is in the process of being submitted.
  inProgress,

  /// The form has been submitted successfully.
  success,

  /// The form submission failed.
  failure,

  /// The form submission has been canceled.
  canceled
}

/// Useful extensions on [FormzSubmissionStatus]
extension FormzSubmissionStatusX on FormzSubmissionStatus {
  /// Indicates whether the form has not yet been submitted.
  bool get isInitial => this == FormzSubmissionStatus.initial;

  /// Indicates whether the form is in the process of being submitted.
  bool get isInProgress => this == FormzSubmissionStatus.inProgress;

  /// Indicates whether the form has been submitted successfully.
  bool get isSuccess => this == FormzSubmissionStatus.success;

  /// Indicates whether the form submission failed.
  bool get isFailure => this == FormzSubmissionStatus.failure;

  /// Indicates whether the form submission has been canceled.
  bool get isCanceled => this == FormzSubmissionStatus.canceled;
}

/// {@template form_input}
/// A [FormzInputBase] represents the base class of the [FormzInput] and
/// [AsyncFormzInput] classes. This class is used to validate by the [Formz]
/// class its validate method.
///
/// ```dart
/// final FormzInput syncInput = NameInput.dirty(value: 'jan');
/// final AsyncFormzInput asyncInput = EmailInput.dirty(value: 'test@test.com'),
///
/// const inputs = <FormzInputBase>[
///   FormzInput,
///   AsyncFormzInput,
/// ];
///
/// final status = Formz.validate(validInputs);
/// ```
/// {@endtemplate}
@immutable
abstract class FormzInputBase<T, E> {
  /// The value of the given [FormzInput].
  /// For example, if you have a `FormzInput` for `FirstName`,
  /// the value could be 'Joe'.
  T get value;

  /// If the [FormzInput] is pure (has been touched/modified).
  /// Typically when the `FormzInput` is initially created,
  /// it is created using the `FormzInput.pure` constructor to
  /// signify that the user has not modified it.
  ///
  /// For subsequent changes (in response to user input), the
  /// `FormzInput.dirty` constructor should be used to signify that
  /// the `FormzInput` has been manipulated.
  bool get isPure;

  /// Whether the [FormzInput] value is valid according to the
  /// overridden `validator`.
  ///
  /// Returns `true` if `validator` returns `null` for the
  /// current [FormzInput] value and `false` otherwise.
  bool get isValid;

  /// Whether the [FormzInput] value is not valid.
  /// A value is invalid when the overridden `validator`
  /// returns an error (non-null value).
  bool get isNotValid => !isValid;

  /// Returns a validation error if the [FormzInput] is invalid.
  /// Returns `null` if the [FormzInput] is valid.
  E? get error;
}

/// {@template form_input}
/// A [FormzInput] represents the value of a single form input field.
/// It contains information about the [value] as well as validity.
///
/// [FormzInput] should be extended to define custom [FormzInput] instances.
///
/// ```dart
/// enum FirstNameError { empty }
/// class FirstName extends FormzInput<String, FirstNameError> {
///   const FirstName.pure({String value = ''}) : super.pure(value);
///   const FirstName.dirty({String value = ''}) : super.dirty(value);
///
///   @override
///   FirstNameError? validator(String value) {
///     return value.isEmpty ? FirstNameError.empty : null;
///   }
/// }
/// ```
/// {@endtemplate}
@immutable
abstract class FormzInput<T, E> implements FormzInputBase<T, E> {
  const FormzInput._({required this.value, this.isPure = true});

  /// Constructor which create a `pure` [FormzInput] with a given value.
  const FormzInput.pure(T value) : this._(value: value);

  /// Constructor which create a `dirty` [FormzInput] with a given value.
  const FormzInput.dirty(T value) : this._(value: value, isPure: false);

  @override
  final T value;

  @override
  final bool isPure;

  @override
  bool get isValid => validator(value) == null;

  @override
  bool get isNotValid => !isValid;

  @override
  E? get error => validator(value);

  /// The error to display if the [FormzInput] value
  /// is not valid and has been modified.
  E? get displayError => isPure ? null : error;

  /// A function that must return a validation error if the provided
  /// [value] is invalid and `null` otherwise.
  E? validator(T value);

  @override
  int get hashCode => Object.hashAll([value, isPure]);

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is FormzInput<T, E> &&
        other.value == value &&
        other.isPure == isPure;
  }

  @override
  String toString() {
    return isPure
        ? '''FormzInput<$T, $E>.pure(value: $value, isValid: $isValid, error: $error)'''
        : '''FormzInput<$T, $E>.dirty(value: $value, isValid: $isValid, error: $error)''';
  }
}

/// Class which contains methods that help manipulate and manage
/// validity of [FormzInput] instances.
class Formz {
  /// Returns a [bool] given a list of [FormzInput] indicating whether
  /// the inputs are all valid.
  static bool validate(List<FormzInputBase> inputs) {
    return inputs.every((input) => input.isValid);
  }
}

/// Mixin that automatically handles validation of all [FormzInput]s present in
/// the [inputs].
///
/// When mixing this in, you are required to override the [inputs] getter and
/// provide all [FormzInput]s you want to automatically validate.
///
/// ```dart
/// class LoginFormState with FormzMixin {
///  LoginFormState({
///    this.username = const Username.pure(),
///    this.password = const Password.pure(),
///  });
///
///  final Username username;
///  final Password password;
///
///  @override
///  List<FormzInput> get inputs => [username, password];
/// }
/// ```
mixin FormzMixin {
  /// Whether the [FormzInput] values are all valid.
  bool get isValid => Formz.validate(inputs);

  /// Whether the [FormzInput] values are not all valid.
  bool get isNotValid => !isValid;

  /// Returns all [FormzInput] instances.
  ///
  /// Override this and give it all [FormzInput]s in your class that should be
  /// validated automatically.
  List<FormzInput<dynamic, dynamic>> get inputs;
}

/// {@template async_form_input}
/// A [AsyncFormzInputValidator] represents a validator to asynchronously
/// validate a [AsyncFormzInput] field.
///
/// ```dart
///class EmailValidator
///    extends AsyncFormInputValidator<Email, String, EmailValidationError> {
///  const EmailValidator({
///    required EmailRepository emailRepository,
///  }) : _emailRepository = emailRepository;
///
///  final EmailRepository _emailRepository;
///
///  @override
///  Future<EmailValidationError?> validate(Email input) async {
///    if (input.required && input.value.isEmpty) {
///      return const EmailValidationError.required();
///    }
///
///    final alreadyExist = await _emailRepository.findByAddress(input.value);
///    if (alreadyExist) {
///      return const EmailValidationError.alreadyExists();
///    }
///
///    return null;
///  }
///}
/// ```
/// {@endtemplate}
abstract class AsyncFormzInputValidator<
    TInput extends AsyncFormzInput<TValue, TError>, TValue, TError> {
  /// Constructor which creates a [AsyncFormzInputValidator].
  const AsyncFormzInputValidator();

  /// Validates the [input] and returns a [Future] containing the validation
  /// error. Returns null if the [input] is valid.
  ///
  /// ```dart
  ///@override
  ///Future<EmailValidationError?> validate(Email input) async {
  ///  if (input.required && input.value.isEmpty) {
  ///    return const EmailValidationError.required();
  ///  }
  ///
  ///  final alreadyExist = await _emailRepository.findByAddress(input.value);
  ///  if (alreadyExist) {
  ///    return const EmailValidationError.alreadyExists();
  ///  }
  ///
  ///  return null;
  ///}
  /// ```
  @protected
  Future<TError?> validate(TInput input);
}

/// {@template form_input}
/// A [AsyncFormzInput] represents the value of a single form input field.
/// It contains information about the [value] as well as validity.
///
/// [AsyncFormzInput] should be extended to define custom [AsyncFormzInput]
/// instances.
///
/// ```dart
/// enum FirstNameError { empty }
/// class FirstName extends FormzInput<String, FirstNameError> {
///   const FirstName.pure({String value = ''}) : super.pure(value);
///   const FirstName.dirty({String value = ''}) : super.dirty(value);
///
///   @override
///   FirstNameError? validator(String value) {
///     return value.isEmpty ? FirstNameError.empty : null;
///   }
/// }
/// ```
/// {@endtemplate}
@immutable
abstract class AsyncFormzInput<T, E> implements FormzInputBase<T, E> {
  /// Constructor which create a [FormzInput] with a given value.
  const AsyncFormzInput(
    this.value, {
    this.isPure = true,
    this.error,
    this.validating = false,
  });

  /// Constructor which create a `pure` [AsyncFormzInput] with a given value.
  const AsyncFormzInput.pure(T value) : this(value);

  /// Constructor which create a `dirty` [AsyncFormzInput] with a given value.
  const AsyncFormzInput.dirty(
    T value, {
    E? error,
    bool validating = false,
  }) : this(
          value,
          isPure: false,
          error: error,
          validating: validating,
        );

  @override
  final T value;

  @override
  final bool isPure;

  @override
  bool get isValid => error == null;

  @override
  bool get isNotValid => !isValid;

  @override
  final E? error;

  /// Whether the [FormzInput] value is busy validating.
  final bool validating;

  @override
  int get hashCode =>
      value.hashCode ^ isPure.hashCode ^ error.hashCode ^ validating.hashCode;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is AsyncFormzInput<T, E> &&
        other.value == value &&
        other.isPure == isPure &&
        other.error == error &&
        other.validating == validating;
  }

  @override
  String toString() => '''
$runtimeType(
  value: $value, 
  isPure: $isPure, 
  error: $error, 
  validating: $validating
)''';
}
