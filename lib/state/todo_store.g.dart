// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TodoStore on _TodoStore, Store {
  Computed<StoreState> _$stateComputed;

  @override
  StoreState get state => (_$stateComputed ??=
          Computed<StoreState>(() => super.state, name: '_TodoStore.state'))
      .value;

  final _$_getListFutureAtom = Atom(name: '_TodoStore._getListFuture');

  @override
  ObservableFuture<List<Todo>> get _getListFuture {
    _$_getListFutureAtom.reportRead();
    return super._getListFuture;
  }

  @override
  set _getListFuture(ObservableFuture<List<Todo>> value) {
    _$_getListFutureAtom.reportWrite(value, super._getListFuture, () {
      super._getListFuture = value;
    });
  }

  final _$todosAtom = Atom(name: '_TodoStore.todos');

  @override
  List<Todo> get todos {
    _$todosAtom.reportRead();
    return super.todos;
  }

  @override
  set todos(List<Todo> value) {
    _$todosAtom.reportWrite(value, super.todos, () {
      super.todos = value;
    });
  }

  final _$errorMessageAtom = Atom(name: '_TodoStore.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  final _$getListAsyncAction = AsyncAction('_TodoStore.getList');

  @override
  Future<dynamic> getList() {
    return _$getListAsyncAction.run(() => super.getList());
  }

  final _$postAsyncAction = AsyncAction('_TodoStore.post');

  @override
  Future<dynamic> post(Todo todo) {
    return _$postAsyncAction.run(() => super.post(todo));
  }

  final _$updateAsyncAction = AsyncAction('_TodoStore.update');

  @override
  Future<dynamic> update(Todo todo) {
    return _$updateAsyncAction.run(() => super.update(todo));
  }

  final _$removeAsyncAction = AsyncAction('_TodoStore.remove');

  @override
  Future<dynamic> remove(int id) {
    return _$removeAsyncAction.run(() => super.remove(id));
  }

  @override
  String toString() {
    return '''
todos: ${todos},
errorMessage: ${errorMessage},
state: ${state}
    ''';
  }
}
