// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_viewmodel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CartState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<CartItem> items, double total) loaded,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<CartItem> items, double total)? loaded,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<CartItem> items, double total)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CartStateLoading value) loading,
    required TResult Function(CartStateLoaded value) loaded,
    required TResult Function(CartStateError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CartStateLoading value)? loading,
    TResult? Function(CartStateLoaded value)? loaded,
    TResult? Function(CartStateError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CartStateLoading value)? loading,
    TResult Function(CartStateLoaded value)? loaded,
    TResult Function(CartStateError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartStateCopyWith<$Res> {
  factory $CartStateCopyWith(CartState value, $Res Function(CartState) then) =
      _$CartStateCopyWithImpl<$Res, CartState>;
}

/// @nodoc
class _$CartStateCopyWithImpl<$Res, $Val extends CartState>
    implements $CartStateCopyWith<$Res> {
  _$CartStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$CartStateLoadingImplCopyWith<$Res> {
  factory _$$CartStateLoadingImplCopyWith(
    _$CartStateLoadingImpl value,
    $Res Function(_$CartStateLoadingImpl) then,
  ) = __$$CartStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CartStateLoadingImplCopyWithImpl<$Res>
    extends _$CartStateCopyWithImpl<$Res, _$CartStateLoadingImpl>
    implements _$$CartStateLoadingImplCopyWith<$Res> {
  __$$CartStateLoadingImplCopyWithImpl(
    _$CartStateLoadingImpl _value,
    $Res Function(_$CartStateLoadingImpl) _then,
  ) : super(_value, _then);
}

/// @nodoc

class _$CartStateLoadingImpl implements CartStateLoading {
  const _$CartStateLoadingImpl();

  @override
  String toString() {
    return 'CartState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CartStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<CartItem> items, double total) loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<CartItem> items, double total)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<CartItem> items, double total)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CartStateLoading value) loading,
    required TResult Function(CartStateLoaded value) loaded,
    required TResult Function(CartStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CartStateLoading value)? loading,
    TResult? Function(CartStateLoaded value)? loaded,
    TResult? Function(CartStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CartStateLoading value)? loading,
    TResult Function(CartStateLoaded value)? loaded,
    TResult Function(CartStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class CartStateLoading implements CartState {
  const factory CartStateLoading() = _$CartStateLoadingImpl;
}

/// @nodoc
abstract class _$$CartStateLoadedImplCopyWith<$Res> {
  factory _$$CartStateLoadedImplCopyWith(
    _$CartStateLoadedImpl value,
    $Res Function(_$CartStateLoadedImpl) then,
  ) = __$$CartStateLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<CartItem> items, double total});
}

/// @nodoc
class __$$CartStateLoadedImplCopyWithImpl<$Res>
    extends _$CartStateCopyWithImpl<$Res, _$CartStateLoadedImpl>
    implements _$$CartStateLoadedImplCopyWith<$Res> {
  __$$CartStateLoadedImplCopyWithImpl(
    _$CartStateLoadedImpl _value,
    $Res Function(_$CartStateLoadedImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? items = null, Object? total = null}) {
    return _then(
      _$CartStateLoadedImpl(
        null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<CartItem>,
        null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc

class _$CartStateLoadedImpl implements CartStateLoaded {
  const _$CartStateLoadedImpl(final List<CartItem> items, this.total)
    : _items = items;

  final List<CartItem> _items;
  @override
  List<CartItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final double total;

  @override
  String toString() {
    return 'CartState.loaded(items: $items, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CartStateLoadedImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.total, total) || other.total == total));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_items),
    total,
  );

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CartStateLoadedImplCopyWith<_$CartStateLoadedImpl> get copyWith =>
      __$$CartStateLoadedImplCopyWithImpl<_$CartStateLoadedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<CartItem> items, double total) loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(items, total);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<CartItem> items, double total)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(items, total);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<CartItem> items, double total)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(items, total);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CartStateLoading value) loading,
    required TResult Function(CartStateLoaded value) loaded,
    required TResult Function(CartStateError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CartStateLoading value)? loading,
    TResult? Function(CartStateLoaded value)? loaded,
    TResult? Function(CartStateError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CartStateLoading value)? loading,
    TResult Function(CartStateLoaded value)? loaded,
    TResult Function(CartStateError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class CartStateLoaded implements CartState {
  const factory CartStateLoaded(
    final List<CartItem> items,
    final double total,
  ) = _$CartStateLoadedImpl;

  List<CartItem> get items;
  double get total;
  @JsonKey(ignore: true)
  _$$CartStateLoadedImplCopyWith<_$CartStateLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CartStateErrorImplCopyWith<$Res> {
  factory _$$CartStateErrorImplCopyWith(
    _$CartStateErrorImpl value,
    $Res Function(_$CartStateErrorImpl) then,
  ) = __$$CartStateErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$CartStateErrorImplCopyWithImpl<$Res>
    extends _$CartStateCopyWithImpl<$Res, _$CartStateErrorImpl>
    implements _$$CartStateErrorImplCopyWith<$Res> {
  __$$CartStateErrorImplCopyWithImpl(
    _$CartStateErrorImpl _value,
    $Res Function(_$CartStateErrorImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$CartStateErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$CartStateErrorImpl implements CartStateError {
  const _$CartStateErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'CartState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CartStateErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CartStateErrorImplCopyWith<_$CartStateErrorImpl> get copyWith =>
      __$$CartStateErrorImplCopyWithImpl<_$CartStateErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<CartItem> items, double total) loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<CartItem> items, double total)? loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<CartItem> items, double total)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CartStateLoading value) loading,
    required TResult Function(CartStateLoaded value) loaded,
    required TResult Function(CartStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CartStateLoading value)? loading,
    TResult? Function(CartStateLoaded value)? loaded,
    TResult? Function(CartStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CartStateLoading value)? loading,
    TResult Function(CartStateLoaded value)? loaded,
    TResult Function(CartStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class CartStateError implements CartState {
  const factory CartStateError(final String message) = _$CartStateErrorImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$CartStateErrorImplCopyWith<_$CartStateErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
