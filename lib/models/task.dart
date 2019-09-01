class Task {
  final String name;
  bool isDone;

  Task({
    this.name,
    this.isDone = false,
  });
  void toggleDone() {
    isDone = !isDone;
  }

  String getName() => this.name;

  bool getToogleIsDone(Task task) {
    return task.isDone;
  }
}
