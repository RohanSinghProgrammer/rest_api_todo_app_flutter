import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rest_api_todo_app_flutter/screens/add_todos.dart';
import 'package:rest_api_todo_app_flutter/services/alerts.dart';
import 'package:rest_api_todo_app_flutter/services/todos.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddTodo(),
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
          child: ListView.builder(
            itemBuilder: (context, index) {
              final item = all_todos[index] as Map;
              return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.cyan[700],
                    child: Text(
                      (index + 1).toString(),
                    ),
                  ),
                  title: Text(item['title']),
                  subtitle: Text(item['description']),
                  trailing: PopupMenuButton(
                      itemBuilder: (context) => const [
                            PopupMenuItem(
                              value: 1,
                              child: Text("Delete"),
                            ),
                            PopupMenuItem(
                              value: 2,
                              child: Text("Update"),
                            ),
                          ],
                      onSelected: (value) {
                        if (value == 1) {
                          deleteTodo(item['_id'].toString());
                        } else if (value == 2) {
                          // EDIT
                        }
                      }));
            },
            itemCount: all_todos.length,
          ),
        ),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
