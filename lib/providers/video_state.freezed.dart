// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'video_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Player {
  String get playerId => throw _privateConstructorUsedError;
  MediaItem? get currentMediaItem => throw _privateConstructorUsedError;
  int? get playbackPositionMs => throw _privateConstructorUsedError;
  PlaybackState get playbackState => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PlayerCopyWith<Player> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerCopyWith<$Res> {
  factory $PlayerCopyWith(Player value, $Res Function(Player) then) =
      _$PlayerCopyWithImpl<$Res>;
  $Res call(
      {String playerId,
      MediaItem? currentMediaItem,
      int? playbackPositionMs,
      PlaybackState playbackState});
}

/// @nodoc
class _$PlayerCopyWithImpl<$Res> implements $PlayerCopyWith<$Res> {
  _$PlayerCopyWithImpl(this._value, this._then);

  final Player _value;
  // ignore: unused_field
  final $Res Function(Player) _then;

  @override
  $Res call({
    Object? playerId = freezed,
    Object? currentMediaItem = freezed,
    Object? playbackPositionMs = freezed,
    Object? playbackState = freezed,
  }) {
    return _then(_value.copyWith(
      playerId: playerId == freezed
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
      currentMediaItem: currentMediaItem == freezed
          ? _value.currentMediaItem
          : currentMediaItem // ignore: cast_nullable_to_non_nullable
              as MediaItem?,
      playbackPositionMs: playbackPositionMs == freezed
          ? _value.playbackPositionMs
          : playbackPositionMs // ignore: cast_nullable_to_non_nullable
              as int?,
      playbackState: playbackState == freezed
          ? _value.playbackState
          : playbackState // ignore: cast_nullable_to_non_nullable
              as PlaybackState,
    ));
  }
}

/// @nodoc
abstract class _$$_PlayerCopyWith<$Res> implements $PlayerCopyWith<$Res> {
  factory _$$_PlayerCopyWith(_$_Player value, $Res Function(_$_Player) then) =
      __$$_PlayerCopyWithImpl<$Res>;
  @override
  $Res call(
      {String playerId,
      MediaItem? currentMediaItem,
      int? playbackPositionMs,
      PlaybackState playbackState});
}

/// @nodoc
class __$$_PlayerCopyWithImpl<$Res> extends _$PlayerCopyWithImpl<$Res>
    implements _$$_PlayerCopyWith<$Res> {
  __$$_PlayerCopyWithImpl(_$_Player _value, $Res Function(_$_Player) _then)
      : super(_value, (v) => _then(v as _$_Player));

  @override
  _$_Player get _value => super._value as _$_Player;

  @override
  $Res call({
    Object? playerId = freezed,
    Object? currentMediaItem = freezed,
    Object? playbackPositionMs = freezed,
    Object? playbackState = freezed,
  }) {
    return _then(_$_Player(
      playerId: playerId == freezed
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
      currentMediaItem: currentMediaItem == freezed
          ? _value.currentMediaItem
          : currentMediaItem // ignore: cast_nullable_to_non_nullable
              as MediaItem?,
      playbackPositionMs: playbackPositionMs == freezed
          ? _value.playbackPositionMs
          : playbackPositionMs // ignore: cast_nullable_to_non_nullable
              as int?,
      playbackState: playbackState == freezed
          ? _value.playbackState
          : playbackState // ignore: cast_nullable_to_non_nullable
              as PlaybackState,
    ));
  }
}

/// @nodoc

class _$_Player implements _Player {
  const _$_Player(
      {required this.playerId,
      this.currentMediaItem,
      this.playbackPositionMs,
      this.playbackState = PlaybackState.stopped});

  @override
  final String playerId;
  @override
  final MediaItem? currentMediaItem;
  @override
  final int? playbackPositionMs;
  @override
  @JsonKey()
  final PlaybackState playbackState;

  @override
  String toString() {
    return 'Player(playerId: $playerId, currentMediaItem: $currentMediaItem, playbackPositionMs: $playbackPositionMs, playbackState: $playbackState)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Player &&
            const DeepCollectionEquality().equals(other.playerId, playerId) &&
            const DeepCollectionEquality()
                .equals(other.currentMediaItem, currentMediaItem) &&
            const DeepCollectionEquality()
                .equals(other.playbackPositionMs, playbackPositionMs) &&
            const DeepCollectionEquality()
                .equals(other.playbackState, playbackState));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(playerId),
      const DeepCollectionEquality().hash(currentMediaItem),
      const DeepCollectionEquality().hash(playbackPositionMs),
      const DeepCollectionEquality().hash(playbackState));

  @JsonKey(ignore: true)
  @override
  _$$_PlayerCopyWith<_$_Player> get copyWith =>
      __$$_PlayerCopyWithImpl<_$_Player>(this, _$identity);
}

abstract class _Player implements Player {
  const factory _Player(
      {required final String playerId,
      final MediaItem? currentMediaItem,
      final int? playbackPositionMs,
      final PlaybackState playbackState}) = _$_Player;

  @override
  String get playerId;
  @override
  MediaItem? get currentMediaItem;
  @override
  int? get playbackPositionMs;
  @override
  PlaybackState get playbackState;
  @override
  @JsonKey(ignore: true)
  _$$_PlayerCopyWith<_$_Player> get copyWith =>
      throw _privateConstructorUsedError;
}
