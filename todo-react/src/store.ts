import { create } from 'zustand'
import { devtools, persist } from 'zustand/middleware'
import { v4 as uuidv4 } from 'uuid';

export type UUID = ReturnType<typeof uuidv4>


export type TodoState = {
  todos: Todo[],
}

export type TodoStateActions = {
  addTodo: (todo: TodoDetails) => void,
  removeTodo: (id: UUID) => void,
  updateTodo: (id: UUID, todo: TodoDetails) => void,
  toggleTodo: (id: UUID) => void,
}

export type Todo = {
  id: UUID,
  text: string,
  isDone: boolean,
  description?: string,
}

export type TodoDetails = {
  text: string,
  description?: string,
  isDone?: boolean,
}

const useTodoStore = create<TodoState & TodoStateActions>()(
  devtools(
    persist(
      (set) => ({
        todos: [],
        addTodo: (todo: TodoDetails) => {
          set((state: TodoState) => ({
            todos: [...state.todos, { ...todo, id: uuidv4(), isDone: false }]
          }))
        },
        removeTodo: (id: UUID) => {
          set(state => ({
            todos: state.todos.filter(todo => todo.id !== id),
          }))
        },
        updateTodo: (id: UUID, details: TodoDetails) => {
          set(state => ({
            todos: state.todos.map(todo => todo.id === id ? { ...todo, ...details } : todo),
          }))
        },
        toggleTodo: (id: UUID) => {
          set(state => ({
            todos: state.todos.map(todo => todo.id === id ? { ...todo, isDone: !todo.isDone } : todo),
          }))
        },
      }),
      {
        name: 'todo-app',
      }
    )
  )
)


export { useTodoStore };