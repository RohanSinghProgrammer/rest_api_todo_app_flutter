import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rest_api_todo_app_flutter/screens/add_todos.dart';
import 'package:rest_api_todo_app_flutter/services/alerts.dart';
import 'package:rest_api_todo_app_flutter/services/todos.dart';
import 'package:rest_api_todo_app_flutter/widgets/todo_card.dart';

class TodoLists extends StatefulWidget {
  const TodoLists({super.key});

  @override
  State<TodoLists> createState() => _TodoListsState();
}

class _TodoListsState extends State<TodoLists> {
  TodoServices todo = TodoServices();
  AlertService alert = AlertService();
  bool loading = true;
  List all_todos = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future<void> getData() async {
    var value = await todo.getTodos();
    setState(() {
      var tempdata = jsonDecode(value.body);
      all_todos = tempdata["items"];
      loading = false;
    });
  }

  void deleteTodo(id) {
    todo.deleteTodoById(id: id);
    List filteredList =
        all_todos.where((element) => element["_id"] != id).toList();
    setState(() {
      all_todos = filteredList;
    });
    alert.successAlert(context: context, msg: "ToDo Deleted Successfully!");
  }

  void editTodo(Map<String, dynamic> todo) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddTodo(todo: todo)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTodo(),
              ));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.cyan[700],
        ),
        child: const Text(
          "Add ToDo",
          style: TextStyle(color: Colors.white),
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'ToDo Lists',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
        ),
        centerTitle: true,
        backgroundColor: Colors.cyan[700],
      ),
      body: Visibility(
        visible: loading,
        replacement: RefreshIndicator(
          onRefresh: getData,
          child: Visibility(
            visible: all_todos.isNotEmpty,
            replacement: const Center(child: Text('ToDo list is empty')),
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final item = all_todos[index] as Map;
                  return TodoCard(
                    index: index,
                    item: item,
                    editTodo: editTodo,
                    deleteTodo: deleteTodo,
                  );
                },
                itemCount: all_todos.length,
              ),
            ),
          ),
        ),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
