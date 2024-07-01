import 'package:flutter/material.dart';
import 'package:rest_api_todo_app_flutter/screens/todo_lists.dart';
import 'package:rest_api_todo_app_flutter/services/alerts.dart';
import 'package:rest_api_todo_app_flutter/services/todos.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  // controllers
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  // initialize objects
  AlertService alert = AlertService();
  TodoServices todo = TodoServices();
  // Add ToDo Function
  void addToDo() async {
    if (_titleController.text == "" || _descriptionController.text == "") {
      alert.warningAlert(context: context, msg: "Please fill all the fields");
    } else {
      var res = await todo.addTodo(
          title: _titleController.text, desc: _descriptionController.text);
      if (res.statusCode == 201) {
        // ignore: use_build_context_synchronously
        alert.successAlert(context: context, msg: "Todo Added Successfully");
        // clear fields
        _titleController.clear();
        _descriptionController.clear();
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TodoLists(),
            ));
      } else {
        // ignore: use_build_context_synchronously
        alert.errorAlert(context: context, msg: "Something went wrong");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Add ToDo',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          ),
          centerTitle: true,
          backgroundColor: Colors.cyan[700],
        ),
        body: Container(
            padding: const EdgeInsets.all(26),
            child: Column(children: [
              TextField(
                controller: _titleController,
                decoration:
                    const InputDecoration(label: Text('Enter your task')),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _descriptionController,
                keyboardType: TextInputType.multiline,
                minLines: 5,
                maxLines: 8,
                decoration: const InputDecoration(
                    label: Text('Enter task description')),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: addToDo,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan[700],
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Text(
                    'Add ToDo',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ))
            ])));
  }
}
