import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  const TodoCard(
      {super.key,
      required this.index,
      required this.item,
      required this.deleteTodo,
      required this.editTodo});

  final index;
  final item;
  final void Function(String) deleteTodo;
  final void Function(Map<String, dynamic>) editTodo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 14, right: 14),
      child: Card(
        child: ListTile(
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
                    editTodo(item as Map<String, dynamic>);
                  }
                })),
      ),
    );
  }
}
