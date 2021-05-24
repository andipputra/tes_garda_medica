import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final int? id;
  final String? title;
  final String? message;
  final String? time;

  Todo({this.id, this.title, this.message, this.time});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
        id: json['id'],
        title: json['title'],
        message: json['message'],
        time: json['time']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['message'] = this.message;
    data['time'] = this.time;
    return data;
  }

  @override
  List<Object?> get props => [id, title, message, time];
}
