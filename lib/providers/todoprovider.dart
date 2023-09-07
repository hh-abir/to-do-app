import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:to_do/models/todo.dart';
import 'dart:convert';

final todoBoxProvider = Provider<Box<String>>((ref) {
  final box = Hive.box<String>('todo_box');
  return box;
});

final todoListNotifierProvider =
    StateNotifierProvider<TodoListNotifier, List<ToDo>>((ref) {
  final box = ref.watch(todoBoxProvider);
  final initialTodos =
      box.values.map((json) => ToDo.fromJson(jsonDecode(json))).toList();
  final showlist = initialTodos.reversed.toList();
  return TodoListNotifier(ref.read, showlist);
});

class TodoListNotifier extends StateNotifier<List<ToDo>> {
  TodoListNotifier(
    this._read,
    List<ToDo> state,
  ) : super(state);
  final dynamic _read;

  void addTodo(String title) {
    final todo = ToDo(title: title, checked: false);
    // final box = Hive.box<String>('todo_box');
    _read(todoBoxProvider).add(jsonEncode(todo));
    state = [todo, ...state];
  }

  void toggleTodoCompletion(int index) {
    if (index >= 0 && index < state.length) {
      final todo = state[index];
      todo.checked = !todo.checked;
      _read(todoBoxProvider).putAt(index, jsonEncode(todo));
      state = [...state];
    }
  }

  void deleteTodo(int index) {
    if (index >= 0 && index < state.length) {
      // ignore: unused_local_variable
      state.removeAt(index);
      _read(todoBoxProvider).deleteAt(index);
      state = [...state];
    }
  }
}
