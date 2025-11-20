// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'catalog_viewmodel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CatalogState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Product> products) loaded,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Product> products)? loaded,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Product> products)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CatalogStateLoading value) loading,
    required TResult Function(CatalogStateLoaded value) loaded,
    required TResult Function(CatalogStateError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CatalogStateLoading value)? loading,
    TResult? Function(CatalogStateLoaded value)? loaded,
    TResult? Function(CatalogStateError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CatalogStateLoading value)? loading,
    TResult Function(CatalogStateLoaded value)? loaded,
    TResult Function(CatalogStateError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CatalogStateCopyWith<$Res> {
  factory $CatalogStateCopyWith(
    CatalogState value,
    $Res Function(CatalogState) then,
  ) = _$CatalogStateCopyWithImpl<$Res, CatalogState>;
}

/// @nodoc
class _$CatalogStateCopyWithImpl<$Res, $Val extends CatalogState>
    implements $CatalogStateCopyWith<$Res> {
  _$CatalogStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$CatalogStateLoadingImplCopyWith<$Res> {
  factory _$$CatalogStateLoadingImplCopyWith(
    _$CatalogStateLoadingImpl value,
    $Res Function(_$CatalogStateLoadingImpl) then,
  ) = __$$CatalogStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CatalogStateLoadingImplCopyWithImpl<$Res>
    extends _$CatalogStateCopyWithImpl<$Res, _$CatalogStateLoadingImpl>
    implements _$$CatalogStateLoadingImplCopyWith<$Res> {
  __$$CatalogStateLoadingImplCopyWithImpl(
    _$CatalogStateLoadingImpl _value,
    $Res Function(_$CatalogStateLoadingImpl) _then,
  ) : super(_value, _then);
}

/// @nodoc

class _$CatalogStateLoadingImpl implements CatalogStateLoading {
  const _$CatalogStateLoadingImpl();

  @override
  String toString() {
    return 'CatalogState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CatalogStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Product> products) loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Product> products)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Product> products)? loaded,
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
    required TResult Function(CatalogStateLoading value) loading,
    required TResult Function(CatalogStateLoaded value) loaded,
    required TResult Function(CatalogStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CatalogStateLoading value)? loading,
    TResult? Function(CatalogStateLoaded value)? loaded,
    TResult? Function(CatalogStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CatalogStateLoading value)? loading,
    TResult Function(CatalogStateLoaded value)? loaded,
    TResult Function(CatalogStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class CatalogStateLoading implements CatalogState {
  const factory CatalogStateLoading() = _$CatalogStateLoadingImpl;
}

/// @nodoc
abstract class _$$CatalogStateLoadedImplCopyWith<$Res> {
  factory _$$CatalogStateLoadedImplCopyWith(
    _$CatalogStateLoadedImpl value,
    $Res Function(_$CatalogStateLoadedImpl) then,
  ) = __$$CatalogStateLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Product> products});
}

/// @nodoc
class __$$CatalogStateLoadedImplCopyWithImpl<$Res>
    extends _$CatalogStateCopyWithImpl<$Res, _$CatalogStateLoadedImpl>
    implements _$$CatalogStateLoadedImplCopyWith<$Res> {
  __$$CatalogStateLoadedImplCopyWithImpl(
    _$CatalogStateLoadedImpl _value,
    $Res Function(_$CatalogStateLoadedImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? products = null}) {
    return _then(
      _$CatalogStateLoadedImpl(
        null == products
            ? _value._products
            : products // ignore: cast_nullable_to_non_nullable
                  as List<Product>,
      ),
    );
  }
}

/// @nodoc

class _$CatalogStateLoadedImpl implements CatalogStateLoaded {
  const _$CatalogStateLoadedImpl(final List<Product> products)
    : _products = products;

  final List<Product> _products;
  @override
  List<Product> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  @override
  String toString() {
    return 'CatalogState.loaded(products: $products)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CatalogStateLoadedImpl &&
            const DeepCollectionEquality().equals(other._products, _products));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_products));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CatalogStateLoadedImplCopyWith<_$CatalogStateLoadedImpl> get copyWith =>
      __$$CatalogStateLoadedImplCopyWithImpl<_$CatalogStateLoadedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Product> products) loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(products);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Product> products)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(products);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Product> products)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(products);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CatalogStateLoading value) loading,
    required TResult Function(CatalogStateLoaded value) loaded,
    required TResult Function(CatalogStateError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CatalogStateLoading value)? loading,
    TResult? Function(CatalogStateLoaded value)? loaded,
    TResult? Function(CatalogStateError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CatalogStateLoading value)? loading,
    TResult Function(CatalogStateLoaded value)? loaded,
    TResult Function(CatalogStateError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class CatalogStateLoaded implements CatalogState {
  const factory CatalogStateLoaded(final List<Product> products) =
      _$CatalogStateLoadedImpl;

  List<Product> get products;
  @JsonKey(ignore: true)
  _$$CatalogStateLoadedImplCopyWith<_$CatalogStateLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CatalogStateErrorImplCopyWith<$Res> {
  factory _$$CatalogStateErrorImplCopyWith(
    _$CatalogStateErrorImpl value,
    $Res Function(_$CatalogStateErrorImpl) then,
  ) = __$$CatalogStateErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$CatalogStateErrorImplCopyWithImpl<$Res>
    extends _$CatalogStateCopyWithImpl<$Res, _$CatalogStateErrorImpl>
    implements _$$CatalogStateErrorImplCopyWith<$Res> {
  __$$CatalogStateErrorImplCopyWithImpl(
    _$CatalogStateErrorImpl _value,
    $Res Function(_$CatalogStateErrorImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$CatalogStateErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$CatalogStateErrorImpl implements CatalogStateError {
  const _$CatalogStateErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'CatalogState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CatalogStateErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CatalogStateErrorImplCopyWith<_$CatalogStateErrorImpl> get copyWith =>
      __$$CatalogStateErrorImplCopyWithImpl<_$CatalogStateErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Product> products) loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Product> products)? loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Product> products)? loaded,
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
    required TResult Function(CatalogStateLoading value) loading,
    required TResult Function(CatalogStateLoaded value) loaded,
    required TResult Function(CatalogStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CatalogStateLoading value)? loading,
    TResult? Function(CatalogStateLoaded value)? loaded,
    TResult? Function(CatalogStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CatalogStateLoading value)? loading,
    TResult Function(CatalogStateLoaded value)? loaded,
    TResult Function(CatalogStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class CatalogStateError implements CatalogState {
  const factory CatalogStateError(final String message) =
      _$CatalogStateErrorImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$CatalogStateErrorImplCopyWith<_$CatalogStateErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
