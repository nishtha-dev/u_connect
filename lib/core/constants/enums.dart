enum GoalDetailsDataStatus { initial, loading, success, failure }

extension GoalDetailsDataStatusX on GoalDetailsDataStatus {
  bool get isInitial => this == GoalDetailsDataStatus.initial;
  bool get isLoading => this == GoalDetailsDataStatus.loading;
  bool get isSuccess => this == GoalDetailsDataStatus.success;
  bool get isFailure => this == GoalDetailsDataStatus.failure;
}
