import { Todo, useTodoStore, UUID } from "../store";

function Todo({ id, isDone, text, description }: Todo) {
  function toggleDone(id: UUID) {
    const todoStore = useTodoStore();
    todoStore.toggleTodo(id);
  }

  return (
    <>
      <div onClick={() => toggleDone(id)}>{text}</div>
      <div>{description}</div>
    </>
  )
}


export { Todo };