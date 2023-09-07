import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do/app_detail.dart';

import 'package:to_do/models/todo.dart';
import 'package:to_do/providers/todoprovider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<String>('todo_box');
  Hive.registerAdapter(ToDoAdapter());

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "magic font"),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(todoListNotifierProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFB57956),
      appBar: AppBar(
        title: GestureDetector(
          onLongPress: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AppDetail()));
          },
          child: const Text(
            "To Do",
            style: TextStyle(
              color: Color(0xFFD0931E),
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color(0xFFFBE049),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: todos.isEmpty
            ? const Center(
                child: Text("No task for today"),
              )
            : ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      tileColor: Colors.white,
                      leading: IconButton(
                        onPressed: () {
                          ref
                              .read(todoListNotifierProvider.notifier)
                              .toggleTodoCompletion(index);
                        },
                        icon: Image.asset(
                            "assets/icons/${todo.checked ? "checked" : "unchecked"}.png"),
                      ),
                      title: Text(
                        todo.title,
                        style: TextStyle(
                            decoration: todo.checked
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            color: todo.checked ? Colors.grey : Colors.black),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          ref
                              .read(todoListNotifierProvider.notifier)
                              .deleteTodo(index);
                        },
                        icon: Image.asset("assets/icons/cross.png"),
                      ),
                    ),
                  );
                }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                String userInput = "";
                return AlertDialog(
                  backgroundColor: const Color(0xFFe9e9e9),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        autofocus: true,
                        onChanged: (value) {
                          userInput = value;
                        },
                        cursorColor: const Color(0xFFD0931E),
                        decoration: const InputDecoration(
                            labelText: "Add Task ...",
                            floatingLabelStyle:
                                TextStyle(color: Color(0xFFD0931E)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black))),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xFFD0931E))),
                          onPressed: () {
                            if (userInput.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Task cannot be empty'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                              Navigator.pop(context);
                            } else {
                              ref
                                  .read(todoListNotifierProvider.notifier)
                                  .addTodo(userInput);

                              Navigator.pop(context);
                            }
                          },
                          child: const Text("Add Task"))
                    ],
                  ),
                );
              });
        },
        backgroundColor: const Color(0xFFD0931E),
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
