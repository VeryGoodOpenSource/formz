import 'dart:async';

import 'package:meta/meta.dart';

class _FormzException implements Exception {
  const _FormzException();
}

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

  /// Indicates whether the form is either in progress or has been submitted
  /// successfully.
  ///
  /// This is useful for showing a loading indicator or disabling the submit
  /// button to prevent duplicate submissions.
  bool get isInProgressOrSuccess => isInProgress || isSuccess;
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
abstract class FormzInput<T, E> {
  const FormzInput._({required this.value, this.isPure = true});

  /// Constructor which create a `pure` [FormzInput] with a given value.
  const FormzInput.pure(T value) : this._(value: value);

  /// Constructor which create a `dirty` [FormzInput] with a given value.
  const FormzInput.dirty(T value) : this._(value: value, isPure: false);

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
  final bool isPure;

  /// Whether the [FormzInput] value is valid according to the
  /// overridden `validator`.
  ///
  /// Returns `true` if `validator` returns `null` for the
  /// current [FormzInput] value and `false` otherwise.
  FutureOr<bool> get isValid async => await validator(value) == null;

  /// Whether the [FormzInput] value is not valid.
  /// A value is invalid when the overridden `validator`
  /// returns an error (non-null value).
  FutureOr<bool> get isNotValid async => !(await isValid);

  /// Returns a validation error if the [FormzInput] is invalid.
  /// Returns `null` if the [FormzInput] is valid.
  FutureOr<E?> get error async => await validator(value);

  /// The error to display if the [FormzInput] value
  /// is not valid and has been modified.
  FutureOr<E?> get displayError => isPure ? null : error;

  /// A function that must return a validation error if the provided
  /// [value] is invalid and `null` otherwise.
  FutureOr<E?> validator(T value);

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

/// Mixin for [FormzInput] that caches the [error] result of the [validator].
/// Use this mixin when implementations that make expensive computations are
/// used, such as those involving regular expressions.
mixin FormzInputErrorCacheMixin<T, E> on FormzInput<T, E> {
  late final FutureOr<E?> _error = validator(value);

  @override
  FutureOr<E?> get error => _error;

  @override
  bool get isValid => _error == null;
}

/// Class which contains methods that help manipulate and manage
/// validity of [FormzInput] instances.
class Formz {
  /// Returns whether or not a given a list of [FormzInput] has all valid
  /// inputs.
  ///
  /// This method will return `true` if all inputs are valid and `false`
  /// otherwise.
  ///
  /// If some inputs validations are asynchronous, this method will return as
  /// soon as one of the inputs is invalid. Otherwise, it will wait for all
  /// inputs to be validated before returning.
  static FutureOr<bool> validate(
    List<FormzInput<dynamic, dynamic>> inputs,
  ) async {
    Future<void> throws(FutureOr<bool> value) async {
      if (await value) return;
      throw const _FormzException();
    }

    final validators = inputs.map((input) => input.isValid);
    try {
      // We have to wrap the futures and ensure they throw an exception
      // if they are not valid. This is because Future.wait `eagerError`
      // will only stop at the first exception it encounters.
      final wrappedFutures = validators.map(throws);
      await Future.wait(wrappedFutures, eagerError: true);
    } on _FormzException {
      return false;
    }

    return true;
  }

  /// Returns a [bool] given a list of [FormzInput] indicating whether
  /// all the inputs are pure.
  static bool isPure(List<FormzInput<dynamic, dynamic>> inputs) {
    return inputs.every((input) => input.isPure);
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
  FutureOr<bool> get isValid async => await Formz.validate(inputs);

  /// Whether the [FormzInput] values are not all valid.
  FutureOr<bool> get isNotValid async => !(await isValid);

  /// Whether all of the [FormzInput] are pure.
  bool get isPure => Formz.isPure(inputs);

  /// Whether at least one of the [FormzInput]s is dirty.
  bool get isDirty => !isPure;

  /// Returns all [FormzInput] instances.
  ///
  /// Override this and give it all [FormzInput]s in your class that should be
  /// validated automatically.
  List<FormzInput<dynamic, dynamic>> get inputs;
}
