import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_todos/models/todo.dart';
import 'package:mobx_todos/repositories/todo_repository.dart';
import 'package:mobx_todos/state/todo_store.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<TodoStore>(create: (_) => TodoStore(TodoRepository()))
        ],
        child: MaterialApp(
          title: 'Flutter Todo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: MyHomePage(title: 'Flutter Todo'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TodoStore _todoStore = new TodoStore(TodoRepository());
  final textTodoController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _todoStore.getList();
  }

  openDialog({bool isEdit = false, int id = 0, String text = ""}) {
    if (isEdit) {
      textTodoController.text = text;
    } else {
			textTodoController.text = "";
		}
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: textTodoController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            Todo _todo = new Todo();
                            _todo.text = textTodoController.text;
                            if (!isEdit) {
                              _todoStore.post(_todo);
                            } else {
                              _todo.id = id;
                              _todoStore.update(_todo);
                            }
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: const Color(0xFF1BC0C5),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (_) => !(_todoStore.state == StoreState.loading)
            ? Scaffold(
                appBar: AppBar(
                  title: Text(widget.title),
                ),
                body: Container(
                    padding: EdgeInsets.all(5),
                    child: ListView.builder(
                        itemCount: _todoStore.todos.length,
                        itemBuilder: (_, index) {
                          final todo = _todoStore.todos[index];
                          return Card(
                              elevation: 10.0,
                              child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                          child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              todo.completed = !todo.completed;
                                              _todoStore.update(todo);
                                            },
                                            child: todo.completed == false
                                                ? Icon(Icons
                                                    .check_box_outline_blank)
                                                : Icon(Icons.check_box),
                                          ),
                                          SizedBox(width: 10),
                                          Text('${todo.text}'),
                                        ],
                                      )),
                                      Container(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          FlatButton(
                                            splashColor: Colors.blueAccent,
                                            onPressed: () {
                                              openDialog(
                                                  isEdit: true,
                                                  id: todo.id,
                                                  text: todo.text);
                                            },
                                            child: Text(
                                              "Edit",
                                              style: TextStyle(fontSize: 10.0),
                                            ),
                                          ),
                                          FlatButton(
                                            splashColor: Colors.blueAccent,
                                            onPressed: () {
                                              _todoStore.remove(todo.id);
                                            },
                                            child: Text(
                                              "Remove",
                                              style: TextStyle(fontSize: 10.0),
                                            ),
                                          )
                                        ],
                                      ))
                                    ],
                                  )));
                        })),
                floatingActionButton: FloatingActionButton(
                  onPressed: () => openDialog(),
                  tooltip: 'Add Todo',
                  child: Icon(Icons.add),
                ),
              )
            : Container(
                color: Colors.grey[300],
                width: 70.0,
                height: 70.0,
                child: new Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: new Center(child: new CircularProgressIndicator())),
              ));
  }
}
