import { useState } from 'react';
import './App.css';
import type { UUID } from './store';
import produce from "immer";


import { useTodoStore } from './store'
import { Todo } from './components/Todo';
import { AddTodo } from './components/AddTodo';

function App() {
  const noTodosText = "No todos";

  const todos = useTodoStore(state => state.todos)

  const renderTodos = () => todos.length == 0 ? <p>{noTodosText}</p> :
    todos.map(todo => {
      <Todo key={todo.id} {...todo} />
    })

  return (
    <div className="App">
      <h1>Todo list</h1>
      <>
        <AddTodo />
        {renderTodos()}
      </>
    </div>
  )
}

export default App
