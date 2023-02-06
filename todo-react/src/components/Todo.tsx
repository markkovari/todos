import { Todo, useTodoStore, UUID } from "../store";
import "./Todo.css";

function Todo({ id, isDone, text, description }: Todo) {
  const { toggleTodo } = useTodoStore();

  function toggleDone(id: UUID) {
    toggleTodo(id);
  }

  return (
    <section className={isDone ? "done" : ""}
      onClick={() => toggleDone(id)}>
      <div>{text}</div>
      <div>{description}</div>
    </section>
  )
}


export { Todo };