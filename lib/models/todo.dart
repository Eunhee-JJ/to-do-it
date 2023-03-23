import 'TodoDataSource.dart';

class Todo {
  // 반복 데이터 챌린지에서 연동...?
  Todo({this.id = -1, this.done = false, required this.date, this.name = ''});
  int id;
  bool done;
  DateTime date; // JSON 파싱 해야함
  String name;
}
