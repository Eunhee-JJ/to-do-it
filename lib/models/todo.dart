class Todo {
  bool done = false;
  DateTime date = DateTime.now(); // JSON 파싱 해야함
  String name = '';

  Todo(this.done, this.date, this.name);
  // 반복 데이터 챌린지에서 연동
}
