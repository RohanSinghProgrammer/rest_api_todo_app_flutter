import 'package:flutter/material.dart';
import 'package:rest_api_todo_app_flutter/screens/todo_lists.dart';
import 'package:rest_api_todo_app_flutter/services/alerts.dart';
import 'package:rest_api_todo_app_flutter/services/todos.dart';

class AddTodo extends StatefulWidget {
  AddTodo({super.key, this.todo});

  Map<String, dynamic>? todo;

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  bool isEdit = false;
  // controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // check edit screen or not
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;
      String title = todo['title'];
      String description = todo['description'];
      _titleController.text = title;
      _descriptionController.text = description;
    }
  }

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

  // Update ToDo Function
  void updateToDo() async {
    final old_todo = widget.todo as Map<String, dynamic>;
    final id = old_todo['_id'] as String;
    // check for null values
    if (_titleController.text == "" || _descriptionController.text == "") {
      alert.warningAlert(context: context, msg: "Please fill all the fields");
    }

    var res = await todo.updateTodo(
        id: id,
        title: _titleController.text,
        desc: _descriptionController.text);
    if (res.statusCode == 200) {
      // ignore: use_build_context_synchronously
      alert.successAlert(context: context, msg: "Todo Updated Successfully");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            isEdit ? 'Edit ToDo' : 'Add ToDo',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          ),
          centerTitle: true,
          backgroundColor: Colors.cyan[700],
        ),
        body: Container(
            padding: const EdgeInsets.all(26),
            child: Column(children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(hintText: 'Enter your task'),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _descriptionController,
                keyboardType: TextInputType.multiline,
                minLines: 5,
                maxLines: 8,
                decoration:
                    const InputDecoration(hintText: 'Enter task description'),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: isEdit ? updateToDo : addToDo,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan[700],
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: Text(
                    isEdit ? 'Update' : 'Submit',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ))
            ])));
  }
}
