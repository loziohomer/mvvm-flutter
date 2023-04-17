import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mvvm/model/todo.dart';
import 'package:http/http.dart' as http;

class TodoService {
  final Map<String, String> _headers = <String, String> {
    'Content-Type':'application/json; charset=UTF-8'
  };

  Future<List<Todo>> fetchTodos() async {
    final uri = Uri.parse("http://localhost:8080/todo/get");
    final response = await http.get(uri);

    Iterable i = jsonDecode(response.body);
    return List<Todo>.from(i.map((e) => Todo.fromJson(e)));
  }

  Future addTodo(Todo todo) async {
    final uri = Uri.parse("http://localhost:8080/todo/add");
    final response = await http.post(
      uri,
      body: jsonEncode(todo),
      headers: _headers,
    );
  }

  Future update(Todo todo) async {
    final uri = Uri.parse("http://localhost:8080/todo/update");
    final response = await http.post(
      uri,
      body: jsonEncode(todo),
      headers: _headers,
    );
    debugPrint("Response on update: ${response.statusCode}");
  }
}
