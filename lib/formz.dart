library formz;

/// Enum representing the status of a form at any given point in time.
enum FormzStatus {
  /// The form has not been touched.
  pure,

  /// The form has been completely validated.
  valid,

  /// The form contains one or more invalid inputs.
  invalid,

  /// The form is in the process of being submitted.
  submissionInProgress,

  /// The form has been submitted successfully.
  submissionSuccess,

  /// The form submission failed.
  submissionFailure
}

/// Enum representing the status of a form input at any given point in time.
enum FormzInputStatus {
  /// The form input has not been touched.
  pure,

  /// The form input is valid.
  valid,

  /// The form input is not valid.
  invalid,
}

/// {@template form_input}
/// A [FormzInput] represents the value of a single form input field.
/// It contains information about the [FormzInputStatus], [value], as well
/// as validation status.
///
/// [FormzInput] should be extended to define custom [FormzInputs].
///
/// ```dart
/// enum FirstNameError { empty }
/// class FirstName extends FormzInput<String, FirstNameError> {
///   const FirstName.pure({String value = ''}) : super.pure(value);
///   const FirstName.dirty({String value = ''}) : super.dirty(value);
///
///   @override
///   FirstNameError validator(String value) {
///     return value?.isNotEmpty == true ? null : FirstNameError.empty;
///   }
/// }
/// ```
/// {@endtemplate}
abstract class FormzInput<T, E> {
  const FormzInput._(this.value, [this.pure = true]) : assert(value != null);

  /// Constructor which create a `pure` [FormzInput] with a given value.
  const FormzInput.pure(T value) : this._(value);

  /// Constructor which create a `dirty` [FormzInput] with a given value.
  const FormzInput.dirty(T value) : this._(value, false);

  /// The value of the given [FormzInput].
  /// For example, if you have a `FormzInput` for `FirstName`,
  /// the value could be 'Joe'.
  final T value;

  /// If the [FormzInput] is pure (has been touched/modified).
  /// Typically when the `FormzInput` is initially created,
  /// it is created using the `FormzInput.pure` constructor to
  /// signify that the user has not modified it.
  ///
  /// For subsequent changes (in response to user input), the
  /// `FormzInput.dirty` constructor should be used to signify that
  /// the `FormzInput` has been manipulated.
  final bool pure;

  /// The [FormzInputStatus] which can be one of the following:
  /// * [FormzInputStatus.pure]
  ///   - if the input has not been modified.
  /// * [FormzInputStatus.invalid]
  ///   - if the input has been modified and validation failed.
  /// * [FormzInputStatus.valid]
  ///   - if the input has been modified and validation succeeded.
  FormzInputStatus get status => pure
      ? FormzInputStatus.pure
      : valid ? FormzInputStatus.valid : FormzInputStatus.invalid;

  /// Returns a validation error if the [FormzInput] is invalid.
  /// Returns `null` if the [FormzInput] is valid.
  E get error => validator(value);

  /// Whether the [FormzInput] value is valid according to the
  /// overridden `validator`.
  ///
  /// Returns `true` if `validator` returns `null` for the
  /// current [FormzInput] value and `false` otherwise.
  bool get valid => validator(value) == null;

  /// A function that must return a validation error if the provided
  /// [value] is invalid and `null` otherwise.
  E validator(T value);

  @override
  int get hashCode => value.hashCode ^ pure.hashCode;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is FormzInput<T, E> &&
        other.value == value &&
        other.pure == pure;
  }

  @override
  String toString() => '$runtimeType($value, $pure)';
}

/// Class which contains methods that help manipulate and manage
/// [FormzStatus] and [FormzInputStatus] instances.
class Formz {
  /// Returns a [FormzStatus] given a list of [FormzInput].
  static FormzStatus validate(List<FormzInput> inputs) {
    assert(inputs != null);
    return inputs.any((input) => input.valid == false)
        ? FormzStatus.invalid
        : FormzStatus.valid;
  }
}
