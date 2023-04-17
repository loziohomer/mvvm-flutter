import 'package:flutter/material.dart';
import 'package:mvvm/model/todo.dart';

class AddTodoDialog extends StatefulWidget {
  const AddTodoDialog({Key? key}) : super(key: key);

  @override
  State<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              hintText: "Title",
            ),
          ),
          TextField(
            controller: _descriptionController,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              hintText: "Description",
            ),
          ),
          MaterialButton(
            child: const Text("Save"),
            onPressed: () {
              final todo = Todo(
                id: 0,
                title: _titleController.text.trim(),
                description: _descriptionController.text.trim(),
                completed: false,
              );
              Navigator.of(context).pop(todo);
            },
          ),
        ],
      ),
    );
  }
}
