import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool isScrolled = true;

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  //jsonEncode => 저장할때 , jsonDecode => 불러올때
  //SharedPreferences는 앱을 껏다 켜도 데이터가 유지
  Future<void> _saveTodos() async {
    //앱 내부 저장소(SharedPreferences)를 가져와서 prefs라는 변수를 통해 사용가능하게 해줌
    final prefs = await SharedPreferences.getInstance();
    //리스트(todos)를 JSON 형식의 문자열로 만환해서 저장할 준비
    //jsonEncode()는 SharedPreferences는 문자열만 저장 가능해서 리스트를 문자열(JOSN 형태)로 변환함
    final String encodedData = jsonEncode(todos);
    //할 일 목록을 'todo_list'라는 이름으로 저장
    await prefs.setString('todo_list', encodedData);
  }

  Future<void> _loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    //저장된 할 일 목록을 가져와서 storedData 변수에 저장 만약 없으면 null 될수도 있음
    final String? storedData = prefs.getString('todo_list');

    //만약 저장된 데이터가 있다면 할 일 목록을 업데이트
    //jsonDecode JSON 문자열을 다시 리스트로
    if (storedData != null) {
      setState(() {
        todos = List<Map<String, dynamic>>.from(jsonDecode(storedData));
      });
    }
  }

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
                  _saveTodos();
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
                _saveTodos();
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
    _saveTodos();
  }

  void _toggleComplete(int index) {
    setState(() {
      todos[index]['completed'] = !todos[index]['completed'];
    });
    _saveTodos();
  }

  void _reorderTodos(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex--;
    setState(() {
      final item = todos.removeAt(oldIndex);
      todos.insert(newIndex, item);
    });
    _saveTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: todoAppBar(),
      body: todoBody(),
      floatingActionButton: todoFloating(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: botoomBar(),
    );
  }

// AppBar
  AppBar todoAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text('To Do List'),
      backgroundColor: Colors.white,
      foregroundColor: Colors.blue,
    );
  }

// Body
  Container todoBody() {
    return Container(
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
        child: ReorderableListView(
          onReorder: _reorderTodos,
          children: [
            for (int index = 0; index < todos.length; index++)
              Card(
                key: ValueKey(index),
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
                      // const Icon(Icons.drag_handle), //드래그 핸들
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

//FloatingButton
  FloatingActionButton todoFloating() {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      onPressed: _addTodo,
      tooltip: 'New Note',
      child: const Icon(Icons.add),
    );
  }

//BottomBar
  BottomNavigationBar botoomBar() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: "Settings",
        ),
      ],
    );
  }
}


//구현해 보고싶은기능
//1.redo?
//2.스와이프(좌우로 수정,삭제 하는것)
//3.onboarding구현 
//4.글씨폰트 변경