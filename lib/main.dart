import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.lightBlue,
        scaffoldBackgroundColor: Colors.white,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.lightBlue,
        ),
      ),
      home: const TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Map<String, dynamic>> todos = [
    {'task': '오늘도 할수 있다!', 'completed': false},
  ];
  bool checkMark = false;

  void _addTodo() {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('새로운 할 일 추가'),
          content: TextField(
            controller: controller,
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  setState(() {
                    todos.add({'task': controller.text, 'completed': false});
                  });
                }
                Navigator.of(context).pop();
              },
              child: const Text('추가'),
            ),
          ],
        );
      },
    );
  }

  void _editTodo(int index) {
    TextEditingController controller =
        TextEditingController(text: todos[index]['task']);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('할 일 수정'),
          content: TextField(
            controller: controller,
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  todos[index]['task'] = controller.text;
                });
                Navigator.of(context).pop();
              },
              child: const Text('수정'),
            ),
          ],
        );
      },
    );
  }

  void _deleteTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  void _toggleComplete(int index) {
    setState(() {
      todos[index]['completed'] = !todos[index]['completed'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TodoAppBar(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://img.freepik.com/free-vector/cloud-background-pastel-paper-cut-style-vector_53876-144659.jpg?t=st=1740246693~exp=1740250293~hmac=f3f434b5a9f4e4ee7a49d6cf02f76de4df2bfeeec91c46739bc6ff5605e75991&w=1800',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 3,
                child: ListTile(
                  title: Text(
                    todos[index]['task'],
                    style: TextStyle(
                        decoration: todos[index]['completed']
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  ),
                  leading: IconButton(
                    onPressed: () => _toggleComplete(index),
                    icon: Icon(todos[index]['completed']
                        ? Icons.check_box_outlined
                        : Icons.check_box_outline_blank),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => _editTodo(index),
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                      ),
                      IconButton(
                        onPressed: () => _deleteTodo(index),
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

//앱바
  AppBar TodoAppBar() {
    return AppBar(
      title: const Text('To-Do List'),
      backgroundColor: Colors.lightBlue,
      foregroundColor: Colors.white,
    );
  }
}
