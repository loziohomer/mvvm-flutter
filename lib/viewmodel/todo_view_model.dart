import 'package:flutter/material.dart';
import 'package:mvvm/model/todo.dart';
import 'package:mvvm/service/todo_service.dart';
import 'package:rxdart/subjects.dart';

class TodoViewModel extends ChangeNotifier {
  final _todos = BehaviorSubject<List<Todo>>();
  Stream<List<Todo>> get todoListStream => _todos.stream;

  final TodoService _todoService = TodoService();

  TodoViewModel(){
    _fetchTodos();
  }

  void _fetchTodos() async {
    final list = await _todoService.fetchTodos();
    _todos.add(list);
    notifyListeners();
  }

  void updateTodo(Todo todo, bool completed) async {
    todo.completed = completed;
    await _todoService.update(todo);
    _fetchTodos();
  }

  void addTodo(Todo todo) async {
    await _todoService.addTodo(todo);
    _fetchTodos();
  }

  @override
  void dispose() {
    super.dispose();
    _todos.close();
  }
}