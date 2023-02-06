import { useState } from "react";
import { Todo, useTodoStore, UUID } from "../store";
import "./Todo.css";

function Todo({ id, isDone, text, description }: Todo) {
  const { toggleTodo, removeTodo, updateTodo } = useTodoStore();

  const [todo, setTodo] = useState<Todo>({ id, isDone, text, description });

  const [isUpdating, setIsUpdating] = useState<Boolean>(false);
  const deleteText = "Delete";
  const editText = "Editing";
  const updateText = "Update";
  const doneText = "Done";
  const unDoneText = "Undone";

  function updateTodoHandler() {
    if (isUpdating) {
      updateTodo(id, { ...todo });
    }
    setIsUpdating(!isUpdating);
  }

  return (
    <section className={`row ${isDone ? "done" : ""}`}>
      <div className="todo">
        {isUpdating ? (
          <>
            <input
              type="text"
              name="text"
              id="text"
              placeholder="Todo text"
              onChange={(event) =>
                setTodo({ ...todo, text: event.currentTarget.value })
              }
              value={todo.text}
            />
            <input
              type="text"
              name="description"
              id="description"
              placeholder="Todo description"
              onChange={(event) =>
                setTodo({ ...todo, description: event.currentTarget.value })
              }
              value={todo.description}
            />
            <input
              type="checkbox"
              name="isDone"
              id="isDone"
              onChange={(event) =>
                setTodo({ ...todo, isDone: event.currentTarget.checked })
              }
              checked={todo.isDone}
            />
          </>
        ) : (
          <>
            <div>{text}</div>
            <div>{description}</div>
            <label htmlFor="isDone">
              <input name="isDone" id="isDone" type="checkbox" disabled />
            </label>
          </>
        )}
      </div>
      <div>
        <button onClick={() => updateTodoHandler()}>
          {isUpdating ? updateText : editText}
        </button>
        <button onClick={() => removeTodo(id)}>{deleteText}</button>
      </div>
    </section>
  );
}

export { Todo };
