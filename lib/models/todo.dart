import 'package:hive/hive.dart';
part 'todo.g.dart';

@HiveType(typeId: 1)
class ToDo {
  ToDo({required this.title, required this.checked});

  @HiveField(0)
  final String title;

  @HiveField(1)
  bool checked;

  // factory ToDo.fromJson(Map<String, dynamic> json) {
  //   return ToDo(
  //     title: json['title'],
  //     checked: json['checked'],
  //   );

  // }
  ToDo.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        checked = json['checked'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'checked': checked,
      };
}
