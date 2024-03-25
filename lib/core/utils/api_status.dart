// part 'api_response.freezed.dart';
// part 'api_response.g.dart';

// @Freezed()
sealed class ApiStatus<T>
// with _$ApiStatus
{
  const ApiStatus();
  const factory ApiStatus.initial() = Initial<T>;
  const factory ApiStatus.loading() = Loading<T>;
  const factory ApiStatus.success({required T data}) = Success<T>;
  const factory ApiStatus.failed(String message) = Failed<T>;

  bool get isInitial => this is Initial;
  bool get isSuccess => this is Success;
  bool get isLoading => this is Loading;
  bool get isFailed => this is Failed;

  R when<R>({
    required R Function() initialOrLoading,
    required R Function(T data) success,
    required R Function(String message) failed,
  }) {
    return switch (this) {
      Initial<T>() => initialOrLoading(),
      Loading<T>() => initialOrLoading(),
      Success<T>(data: T d) => success(d),
      Failed<T>(:final message) => failed(message),
    };
  }

  R? whenOrNull<R>({
    R Function()? initialOrLoading,
    R Function(T data)? success,
    R Function(String message)? failed,
  }) {
    return switch (this) {
      Initial<T>() => initialOrLoading?.call(),
      Loading<T>() => initialOrLoading?.call(),
      Success<T>(data: T d) => success?.call(d),
      Failed<T>(:final message) => failed?.call(message),
    };
  }

  // factory ApiStatus.fromJson(Map<String, dynamic> json) =>
  //     _$ApiStatusFromJson(json);
}

final class Initial<T> extends ApiStatus<T> {
  const Initial();
}

final class Loading<T> extends ApiStatus<T> {
  const Loading();
}

final class Success<T> extends ApiStatus<T> {
  final T data;

  const Success({required this.data});
}

final class Failed<T> extends ApiStatus<T> {
  const Failed(this.message);
  final String message;
}
