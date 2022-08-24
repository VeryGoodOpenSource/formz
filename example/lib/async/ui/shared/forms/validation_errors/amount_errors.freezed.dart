// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'amount_errors.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AmountValidationError {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String amount, double min, double max) outOfRange,
    required TResult Function(String amount) parsing,
    required TResult Function() required,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String amount, double min, double max)? outOfRange,
    TResult Function(String amount)? parsing,
    TResult Function()? required,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String amount, double min, double max)? outOfRange,
    TResult Function(String amount)? parsing,
    TResult Function()? required,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OutOfRangeAmountValidationError value) outOfRange,
    required TResult Function(ParsingAmountValidationError value) parsing,
    required TResult Function(RequiredAmountValidationError value) required,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(OutOfRangeAmountValidationError value)? outOfRange,
    TResult Function(ParsingAmountValidationError value)? parsing,
    TResult Function(RequiredAmountValidationError value)? required,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OutOfRangeAmountValidationError value)? outOfRange,
    TResult Function(ParsingAmountValidationError value)? parsing,
    TResult Function(RequiredAmountValidationError value)? required,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AmountValidationErrorCopyWith<$Res> {
  factory $AmountValidationErrorCopyWith(AmountValidationError value,
          $Res Function(AmountValidationError) then) =
      _$AmountValidationErrorCopyWithImpl<$Res>;
}

/// @nodoc
class _$AmountValidationErrorCopyWithImpl<$Res>
    implements $AmountValidationErrorCopyWith<$Res> {
  _$AmountValidationErrorCopyWithImpl(this._value, this._then);

  final AmountValidationError _value;
  // ignore: unused_field
  final $Res Function(AmountValidationError) _then;
}

/// @nodoc
abstract class _$$OutOfRangeAmountValidationErrorCopyWith<$Res> {
  factory _$$OutOfRangeAmountValidationErrorCopyWith(
          _$OutOfRangeAmountValidationError value,
          $Res Function(_$OutOfRangeAmountValidationError) then) =
      __$$OutOfRangeAmountValidationErrorCopyWithImpl<$Res>;
  $Res call({String amount, double min, double max});
}

/// @nodoc
class __$$OutOfRangeAmountValidationErrorCopyWithImpl<$Res>
    extends _$AmountValidationErrorCopyWithImpl<$Res>
    implements _$$OutOfRangeAmountValidationErrorCopyWith<$Res> {
  __$$OutOfRangeAmountValidationErrorCopyWithImpl(
      _$OutOfRangeAmountValidationError _value,
      $Res Function(_$OutOfRangeAmountValidationError) _then)
      : super(_value, (v) => _then(v as _$OutOfRangeAmountValidationError));

  @override
  _$OutOfRangeAmountValidationError get _value =>
      super._value as _$OutOfRangeAmountValidationError;

  @override
  $Res call({
    Object? amount = freezed,
    Object? min = freezed,
    Object? max = freezed,
  }) {
    return _then(_$OutOfRangeAmountValidationError(
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      min: min == freezed
          ? _value.min
          : min // ignore: cast_nullable_to_non_nullable
              as double,
      max: max == freezed
          ? _value.max
          : max // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$OutOfRangeAmountValidationError
    implements OutOfRangeAmountValidationError {
  const _$OutOfRangeAmountValidationError(
      {required this.amount, required this.min, required this.max});

  @override
  final String amount;
  @override
  final double min;
  @override
  final double max;

  @override
  String toString() {
    return 'AmountValidationError.outOfRange(amount: $amount, min: $min, max: $max)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OutOfRangeAmountValidationError &&
            const DeepCollectionEquality().equals(other.amount, amount) &&
            const DeepCollectionEquality().equals(other.min, min) &&
            const DeepCollectionEquality().equals(other.max, max));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(amount),
      const DeepCollectionEquality().hash(min),
      const DeepCollectionEquality().hash(max));

  @JsonKey(ignore: true)
  @override
  _$$OutOfRangeAmountValidationErrorCopyWith<_$OutOfRangeAmountValidationError>
      get copyWith => __$$OutOfRangeAmountValidationErrorCopyWithImpl<
          _$OutOfRangeAmountValidationError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String amount, double min, double max) outOfRange,
    required TResult Function(String amount) parsing,
    required TResult Function() required,
  }) {
    return outOfRange(amount, min, max);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String amount, double min, double max)? outOfRange,
    TResult Function(String amount)? parsing,
    TResult Function()? required,
  }) {
    return outOfRange?.call(amount, min, max);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String amount, double min, double max)? outOfRange,
    TResult Function(String amount)? parsing,
    TResult Function()? required,
    required TResult orElse(),
  }) {
    if (outOfRange != null) {
      return outOfRange(amount, min, max);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OutOfRangeAmountValidationError value) outOfRange,
    required TResult Function(ParsingAmountValidationError value) parsing,
    required TResult Function(RequiredAmountValidationError value) required,
  }) {
    return outOfRange(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(OutOfRangeAmountValidationError value)? outOfRange,
    TResult Function(ParsingAmountValidationError value)? parsing,
    TResult Function(RequiredAmountValidationError value)? required,
  }) {
    return outOfRange?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OutOfRangeAmountValidationError value)? outOfRange,
    TResult Function(ParsingAmountValidationError value)? parsing,
    TResult Function(RequiredAmountValidationError value)? required,
    required TResult orElse(),
  }) {
    if (outOfRange != null) {
      return outOfRange(this);
    }
    return orElse();
  }
}

abstract class OutOfRangeAmountValidationError
    implements AmountValidationError {
  const factory OutOfRangeAmountValidationError(
      {required final String amount,
      required final double min,
      required final double max}) = _$OutOfRangeAmountValidationError;

  String get amount;
  double get min;
  double get max;
  @JsonKey(ignore: true)
  _$$OutOfRangeAmountValidationErrorCopyWith<_$OutOfRangeAmountValidationError>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ParsingAmountValidationErrorCopyWith<$Res> {
  factory _$$ParsingAmountValidationErrorCopyWith(
          _$ParsingAmountValidationError value,
          $Res Function(_$ParsingAmountValidationError) then) =
      __$$ParsingAmountValidationErrorCopyWithImpl<$Res>;
  $Res call({String amount});
}

/// @nodoc
class __$$ParsingAmountValidationErrorCopyWithImpl<$Res>
    extends _$AmountValidationErrorCopyWithImpl<$Res>
    implements _$$ParsingAmountValidationErrorCopyWith<$Res> {
  __$$ParsingAmountValidationErrorCopyWithImpl(
      _$ParsingAmountValidationError _value,
      $Res Function(_$ParsingAmountValidationError) _then)
      : super(_value, (v) => _then(v as _$ParsingAmountValidationError));

  @override
  _$ParsingAmountValidationError get _value =>
      super._value as _$ParsingAmountValidationError;

  @override
  $Res call({
    Object? amount = freezed,
  }) {
    return _then(_$ParsingAmountValidationError(
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ParsingAmountValidationError implements ParsingAmountValidationError {
  const _$ParsingAmountValidationError({required this.amount});

  @override
  final String amount;

  @override
  String toString() {
    return 'AmountValidationError.parsing(amount: $amount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParsingAmountValidationError &&
            const DeepCollectionEquality().equals(other.amount, amount));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(amount));

  @JsonKey(ignore: true)
  @override
  _$$ParsingAmountValidationErrorCopyWith<_$ParsingAmountValidationError>
      get copyWith => __$$ParsingAmountValidationErrorCopyWithImpl<
          _$ParsingAmountValidationError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String amount, double min, double max) outOfRange,
    required TResult Function(String amount) parsing,
    required TResult Function() required,
  }) {
    return parsing(amount);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String amount, double min, double max)? outOfRange,
    TResult Function(String amount)? parsing,
    TResult Function()? required,
  }) {
    return parsing?.call(amount);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String amount, double min, double max)? outOfRange,
    TResult Function(String amount)? parsing,
    TResult Function()? required,
    required TResult orElse(),
  }) {
    if (parsing != null) {
      return parsing(amount);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OutOfRangeAmountValidationError value) outOfRange,
    required TResult Function(ParsingAmountValidationError value) parsing,
    required TResult Function(RequiredAmountValidationError value) required,
  }) {
    return parsing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(OutOfRangeAmountValidationError value)? outOfRange,
    TResult Function(ParsingAmountValidationError value)? parsing,
    TResult Function(RequiredAmountValidationError value)? required,
  }) {
    return parsing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OutOfRangeAmountValidationError value)? outOfRange,
    TResult Function(ParsingAmountValidationError value)? parsing,
    TResult Function(RequiredAmountValidationError value)? required,
    required TResult orElse(),
  }) {
    if (parsing != null) {
      return parsing(this);
    }
    return orElse();
  }
}

abstract class ParsingAmountValidationError implements AmountValidationError {
  const factory ParsingAmountValidationError({required final String amount}) =
      _$ParsingAmountValidationError;

  String get amount;
  @JsonKey(ignore: true)
  _$$ParsingAmountValidationErrorCopyWith<_$ParsingAmountValidationError>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RequiredAmountValidationErrorCopyWith<$Res> {
  factory _$$RequiredAmountValidationErrorCopyWith(
          _$RequiredAmountValidationError value,
          $Res Function(_$RequiredAmountValidationError) then) =
      __$$RequiredAmountValidationErrorCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RequiredAmountValidationErrorCopyWithImpl<$Res>
    extends _$AmountValidationErrorCopyWithImpl<$Res>
    implements _$$RequiredAmountValidationErrorCopyWith<$Res> {
  __$$RequiredAmountValidationErrorCopyWithImpl(
      _$RequiredAmountValidationError _value,
      $Res Function(_$RequiredAmountValidationError) _then)
      : super(_value, (v) => _then(v as _$RequiredAmountValidationError));

  @override
  _$RequiredAmountValidationError get _value =>
      super._value as _$RequiredAmountValidationError;
}

/// @nodoc

class _$RequiredAmountValidationError implements RequiredAmountValidationError {
  const _$RequiredAmountValidationError();

  @override
  String toString() {
    return 'AmountValidationError.required()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequiredAmountValidationError);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String amount, double min, double max) outOfRange,
    required TResult Function(String amount) parsing,
    required TResult Function() required,
  }) {
    return required();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String amount, double min, double max)? outOfRange,
    TResult Function(String amount)? parsing,
    TResult Function()? required,
  }) {
    return required?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String amount, double min, double max)? outOfRange,
    TResult Function(String amount)? parsing,
    TResult Function()? required,
    required TResult orElse(),
  }) {
    if (required != null) {
      return required();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OutOfRangeAmountValidationError value) outOfRange,
    required TResult Function(ParsingAmountValidationError value) parsing,
    required TResult Function(RequiredAmountValidationError value) required,
  }) {
    return required(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(OutOfRangeAmountValidationError value)? outOfRange,
    TResult Function(ParsingAmountValidationError value)? parsing,
    TResult Function(RequiredAmountValidationError value)? required,
  }) {
    return required?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OutOfRangeAmountValidationError value)? outOfRange,
    TResult Function(ParsingAmountValidationError value)? parsing,
    TResult Function(RequiredAmountValidationError value)? required,
    required TResult orElse(),
  }) {
    if (required != null) {
      return required(this);
    }
    return orElse();
  }
}

abstract class RequiredAmountValidationError implements AmountValidationError {
  const factory RequiredAmountValidationError() =
      _$RequiredAmountValidationError;
}
