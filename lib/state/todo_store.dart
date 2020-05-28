
import 'package:mobx/mobx.dart';
import 'package:mobx_todos/models/todo.dart';
import 'package:mobx_todos/repositories/todo_repository.dart';
part 'todo_store.g.dart';

class TodoStore extends _TodoStore with _$TodoStore {
  TodoStore(TodoRepository repository) : super(repository);
}

enum StoreState { initial, loading, loaded }

abstract class _TodoStore with Store {
  final TodoRepository _repository;

  _TodoStore(this._repository);

  @observable
  ObservableFuture<List<Todo>> _getListFuture;
  ObservableFuture<Todo> _postTodoFuture;
  ObservableFuture<Todo> _updateTodoFuture;
  ObservableFuture<void> _remoevTodoFuture;
	
  @observable
  List<Todo> todos;

  @observable
  String errorMessage;

  @computed
  StoreState get state {
    if (_getListFuture == null || _getListFuture.status == FutureStatus.rejected) {
      return StoreState.initial;
    }
    return _getListFuture.status == FutureStatus.pending
        ? StoreState.loading
        : StoreState.loaded;
  }

  @action
  Future getList() async {
    try {
      errorMessage = null;
      _getListFuture = ObservableFuture(_repository.getList());
      todos = await _getListFuture;
    } on NetworkError {
      errorMessage = "Couldn't fetch Todo. Is the device online?";
    }
  }

  @action
  Future post(Todo todo) async {
    try {
      errorMessage = null;
      _postTodoFuture = ObservableFuture(_repository.post(todo));
      Todo _todo = await _postTodoFuture;
      todos = [...todos, _todo];
    } on NetworkError {
      errorMessage = "Couldn't create Todo. Is the device online?";
    }
  }

  @action
  Future update(Todo todo) async {
    try {
      errorMessage = null;
      _updateTodoFuture = ObservableFuture(_repository.update(todo));
      Todo _todo = await _updateTodoFuture;
      int indexTodoUpdate =
          todos.indexWhere((element) => element.id == todo.id);
      List<Todo> startList = todos.sublist(0, indexTodoUpdate);
      List<Todo> lastList = todos.sublist(indexTodoUpdate + 1);
      todos = [...startList, _todo, ...lastList];
    } on NetworkError {
      errorMessage = "Couldn't update Todo. Is the device online?";
    }
  }

  @action
  Future remove(int id) async {
    try {
      errorMessage = null;
      _remoevTodoFuture = ObservableFuture(_repository.remove(id));
      await _remoevTodoFuture;
      int indexTodoUpdate = todos.indexWhere((element) => element.id == id);
      List<Todo> startList = todos.sublist(0, indexTodoUpdate);
      List<Todo> lastList = todos.sublist(indexTodoUpdate + 1);
      todos = [...startList, ...lastList];
    } on NetworkError {
      errorMessage = "Couldn't remove Todo. Is the device online?";
    }
  }
}
