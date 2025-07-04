import 'package:flutter/material.dart';


class MyHomepage extends StatefulWidget {
  const MyHomepage({super.key});

  @override
  State<MyHomepage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {

  List<String> todoList = [];

  final TextEditingController _controller = TextEditingController();

  int updateIndex = -1;

  addList(String task) {
    setState(() {
      todoList.add(task);
      _controller.clear();
    });
  }

  updateListItem(String task, int index) {
    setState(() {
      todoList[index] = task;

      // Reset update index
      updateIndex = -1;
      _controller.clear();
    });
  }

  deleteItem(index) {
    setState(() {
      todoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Todo Application",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              flex: 90,
              child: ListView.builder(
                  itemCount: todoList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      color: Colors.green,
                      child: Container(
                        margin: EdgeInsets.only(left: 20),
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 80,
                              child: Text(
                                todoList[index],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _controller.clear();
                                  _controller.text = todoList[index];
                                  updateIndex = index;
                                });
                              },
                              icon: Icon(
                                Icons.edit,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 10),
                            IconButton(
                              onPressed: () {
                                deleteItem(index);
                              },
                              icon: Icon(
                                Icons.delete,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            Expanded(
                flex: 10,
                child: Row(
                  children: [
                    Expanded(
                      flex: 70,
                      child: SizedBox(
                        height: 60,
                        child: TextFormField(
                          controller: _controller,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.green,
                                )),
                            filled: true,
                            labelText: 'Create Task....',
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    FloatingActionButton(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      onPressed: () {
                        updateIndex != -1
                            ? updateListItem(_controller.text,
                            updateIndex) // Update task if editing
                            : addList(_controller.text); // Add new task
                      },
                      child: Icon(updateIndex != -1
                          ? Icons.edit
                          : Icons.add), // Icon changes based on action
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}