import 'package:flutter/material.dart';
import 'package:mvvm/model/todo.dart';
import 'package:mvvm/viewmodel/todo_view_model.dart';
import 'package:mvvm/widget/add_todo_dialog.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final _viewModel = TodoViewModel();

  @override
  void dispose() {
    super.dispose();
    _viewModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo list"),
      ),
      body: StreamBuilder<List<Todo>>(
        stream: _viewModel.todoListStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          final list = snapshot.data!;
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              final todo = list[index];
              return CheckboxListTile(
                title: Text(todo.title),
                subtitle: Text(todo.description),
                value: todo.completed,
                onChanged: (newValue) {
                  debugPrint("newvalue = $newValue");
                  _viewModel.updateTodo(todo, newValue!);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final todo = await showDialog(
            context: context,
            builder: (context) => const AddTodoDialog(),
          );
          _viewModel.addTodo(todo);
        },
      ),
    );
  }
}
