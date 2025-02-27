// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'survey.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CompletedSurveys _$CompletedSurveysFromJson(Map<String, dynamic> json) {
  return _CompletedSurveys.fromJson(json);
}

/// @nodoc
mixin _$CompletedSurveys {
  List<CompletedSurvey> get completedSurveys =>
      throw _privateConstructorUsedError;

  /// Serializes this CompletedSurveys to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CompletedSurveys
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CompletedSurveysCopyWith<CompletedSurveys> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompletedSurveysCopyWith<$Res> {
  factory $CompletedSurveysCopyWith(
          CompletedSurveys value, $Res Function(CompletedSurveys) then) =
      _$CompletedSurveysCopyWithImpl<$Res, CompletedSurveys>;
  @useResult
  $Res call({List<CompletedSurvey> completedSurveys});
}

/// @nodoc
class _$CompletedSurveysCopyWithImpl<$Res, $Val extends CompletedSurveys>
    implements $CompletedSurveysCopyWith<$Res> {
  _$CompletedSurveysCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CompletedSurveys
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? completedSurveys = null,
  }) {
    return _then(_value.copyWith(
      completedSurveys: null == completedSurveys
          ? _value.completedSurveys
          : completedSurveys // ignore: cast_nullable_to_non_nullable
              as List<CompletedSurvey>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CompletedSurveysImplCopyWith<$Res>
    implements $CompletedSurveysCopyWith<$Res> {
  factory _$$CompletedSurveysImplCopyWith(_$CompletedSurveysImpl value,
          $Res Function(_$CompletedSurveysImpl) then) =
      __$$CompletedSurveysImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<CompletedSurvey> completedSurveys});
}

/// @nodoc
class __$$CompletedSurveysImplCopyWithImpl<$Res>
    extends _$CompletedSurveysCopyWithImpl<$Res, _$CompletedSurveysImpl>
    implements _$$CompletedSurveysImplCopyWith<$Res> {
  __$$CompletedSurveysImplCopyWithImpl(_$CompletedSurveysImpl _value,
      $Res Function(_$CompletedSurveysImpl) _then)
      : super(_value, _then);

  /// Create a copy of CompletedSurveys
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? completedSurveys = null,
  }) {
    return _then(_$CompletedSurveysImpl(
      null == completedSurveys
          ? _value._completedSurveys
          : completedSurveys // ignore: cast_nullable_to_non_nullable
              as List<CompletedSurvey>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CompletedSurveysImpl implements _CompletedSurveys {
  const _$CompletedSurveysImpl(final List<CompletedSurvey> completedSurveys)
      : _completedSurveys = completedSurveys;

  factory _$CompletedSurveysImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompletedSurveysImplFromJson(json);

  final List<CompletedSurvey> _completedSurveys;
  @override
  List<CompletedSurvey> get completedSurveys {
    if (_completedSurveys is EqualUnmodifiableListView)
      return _completedSurveys;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_completedSurveys);
  }

  @override
  String toString() {
    return 'CompletedSurveys(completedSurveys: $completedSurveys)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompletedSurveysImpl &&
            const DeepCollectionEquality()
                .equals(other._completedSurveys, _completedSurveys));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_completedSurveys));

  /// Create a copy of CompletedSurveys
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CompletedSurveysImplCopyWith<_$CompletedSurveysImpl> get copyWith =>
      __$$CompletedSurveysImplCopyWithImpl<_$CompletedSurveysImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CompletedSurveysImplToJson(
      this,
    );
  }
}

abstract class _CompletedSurveys implements CompletedSurveys {
  const factory _CompletedSurveys(
      final List<CompletedSurvey> completedSurveys) = _$CompletedSurveysImpl;

  factory _CompletedSurveys.fromJson(Map<String, dynamic> json) =
      _$CompletedSurveysImpl.fromJson;

  @override
  List<CompletedSurvey> get completedSurveys;

  /// Create a copy of CompletedSurveys
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CompletedSurveysImplCopyWith<_$CompletedSurveysImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CompletedSurvey _$CompletedSurveyFromJson(Map<String, dynamic> json) {
  return _CompletedSurvey.fromJson(json);
}

/// @nodoc
mixin _$CompletedSurvey {
  String get id => throw _privateConstructorUsedError;
  DateTime get expiry => throw _privateConstructorUsedError;

  /// Serializes this CompletedSurvey to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CompletedSurvey
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CompletedSurveyCopyWith<CompletedSurvey> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompletedSurveyCopyWith<$Res> {
  factory $CompletedSurveyCopyWith(
          CompletedSurvey value, $Res Function(CompletedSurvey) then) =
      _$CompletedSurveyCopyWithImpl<$Res, CompletedSurvey>;
  @useResult
  $Res call({String id, DateTime expiry});
}

/// @nodoc
class _$CompletedSurveyCopyWithImpl<$Res, $Val extends CompletedSurvey>
    implements $CompletedSurveyCopyWith<$Res> {
  _$CompletedSurveyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CompletedSurvey
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? expiry = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      expiry: null == expiry
          ? _value.expiry
          : expiry // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CompletedSurveyImplCopyWith<$Res>
    implements $CompletedSurveyCopyWith<$Res> {
  factory _$$CompletedSurveyImplCopyWith(_$CompletedSurveyImpl value,
          $Res Function(_$CompletedSurveyImpl) then) =
      __$$CompletedSurveyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, DateTime expiry});
}

/// @nodoc
class __$$CompletedSurveyImplCopyWithImpl<$Res>
    extends _$CompletedSurveyCopyWithImpl<$Res, _$CompletedSurveyImpl>
    implements _$$CompletedSurveyImplCopyWith<$Res> {
  __$$CompletedSurveyImplCopyWithImpl(
      _$CompletedSurveyImpl _value, $Res Function(_$CompletedSurveyImpl) _then)
      : super(_value, _then);

  /// Create a copy of CompletedSurvey
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? expiry = null,
  }) {
    return _then(_$CompletedSurveyImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      expiry: null == expiry
          ? _value.expiry
          : expiry // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CompletedSurveyImpl implements _CompletedSurvey {
  const _$CompletedSurveyImpl({required this.id, required this.expiry});

  factory _$CompletedSurveyImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompletedSurveyImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime expiry;

  @override
  String toString() {
    return 'CompletedSurvey(id: $id, expiry: $expiry)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompletedSurveyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.expiry, expiry) || other.expiry == expiry));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, expiry);

  /// Create a copy of CompletedSurvey
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CompletedSurveyImplCopyWith<_$CompletedSurveyImpl> get copyWith =>
      __$$CompletedSurveyImplCopyWithImpl<_$CompletedSurveyImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CompletedSurveyImplToJson(
      this,
    );
  }
}

abstract class _CompletedSurvey implements CompletedSurvey {
  const factory _CompletedSurvey(
      {required final String id,
      required final DateTime expiry}) = _$CompletedSurveyImpl;

  factory _CompletedSurvey.fromJson(Map<String, dynamic> json) =
      _$CompletedSurveyImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get expiry;

  /// Create a copy of CompletedSurvey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CompletedSurveyImplCopyWith<_$CompletedSurveyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
