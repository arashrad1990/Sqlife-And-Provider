import 'package:database/Provider/todo_provider.dart';
import 'package:database/screens/todo_add_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class TodoShowScreen extends StatelessWidget {
  const TodoShowScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TodoProvider data = TodoProvider();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddTodoScreen(),
            ),
          );
        },
      ),
      appBar: AppBar(
        title: const Text("Todo"),
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder(
        future: Provider.of<TodoProvider>(context, listen: false).selectData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Consumer<TodoProvider>(
              builder:
                  (BuildContext context, TodoProvider value, Widget? child) {
                return data.todoItem.isNotEmpty
                    ? ListView.builder(
                        itemCount: data.todoItem.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Colors.green,
                            elevation: 5,
                            child: ListTile(
                              style: ListTileStyle.drawer,
                              title: Text(
                                data.todoItem[index].title,
                                style: const TextStyle(color: Colors.black),
                              ),
                              subtitle: Text(
                                data.todoItem[index].description,
                                style: const TextStyle(color: Colors.black),
                              ),
                              trailing: Text(
                                data.todoItem[index].date,
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Text(
                          "List is Empty",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 35,
                          ),
                        ),
                      );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
