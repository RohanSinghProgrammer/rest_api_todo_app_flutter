import 'dart:convert';
import 'package:http/http.dart' as http;

class TodoServices {
  // add ToDo
  Future addTodo({required String title, required String desc}) async {
    const String url = 'https://api.nstack.in/v1/todos';
    try {
      Uri uri = Uri.parse(url);
      final Map<String, dynamic> body = {
        "title": title,
        "description": desc,
        "is_completed": false
      };
      var response = await http.post(uri,
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'});

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  // get ToDo
  Future getTodos() async {
    try {
      const String url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
      Uri uri = Uri.parse(url);
      var response = await http.get(uri);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  // update ToDo
  Future updateTodo(
      {required String id, required String title, required String desc}) async {
    try {
      String url = 'https://api.nstack.in/v1/todos/$id';
      Uri uri = Uri.parse(url);
      final Map<String, dynamic> body = {
        "title": title,
        "description": desc,
        "is_completed": false
      };
      var response = await http.put(uri,
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'});

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  // DELETE TODO
  Future deleteTodoById({required String id}) async {
    try {
      final String url = 'https://api.nstack.in/v1/todos/$id';
      Uri uri = Uri.parse(url);
      var response = await http.delete(uri);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
