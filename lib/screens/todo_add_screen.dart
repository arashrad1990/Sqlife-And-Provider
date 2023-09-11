import 'package:flutter/material.dart';
import 'package:database/Provider/todo_provider.dart';
import 'package:provider/provider.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({Key? key}) : super(key: key);

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final TextEditingController __titile = TextEditingController();
  final TextEditingController __description = TextEditingController();
  final TextEditingController __date = TextEditingController();
  @override
  void dispose() {
    __titile.dispose();
    __description.dispose();
    __date.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          "Create",
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(40),
            child: TextField(
              controller: __titile,
              decoration: const InputDecoration(hintText: "Title"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(40),
            child: TextField(
              controller: __description,
              decoration: const InputDecoration(hintText: "Description"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(40),
            child: TextField(
              controller: __date,
              decoration: const InputDecoration(hintText: "Date"),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () async {
              todoProvider.insertData(
                __titile.text,
                __description.text,
                __date.text,
              );
              __titile.clear();
              __description.clear();
              __date.clear();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.save),
            label: const Text("Save"),
          ),
        ],
      ),
    );
  }
}
