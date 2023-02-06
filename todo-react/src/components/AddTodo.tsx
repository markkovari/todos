import { useState } from "react";
import { useTodoStore } from "../store";

function AddTodo() {
  const addTodoText = "Add todo";
  const [fields, setFields] = useState({
    text: "",
    description: "",
  });

  function handleFieldChange(event: React.ChangeEvent<HTMLInputElement>) {
    const { name, value } = event.currentTarget;
    setFields({ ...fields, [name]: value });
  }

  function addTodo(event: React.FormEvent<HTMLFormElement>) {
    event.preventDefault();
    const [addTodo] = useTodoStore(
      (state) => [state.addTodo],
    );
    addTodo({
      ...fields,
      isDone: false,
    });
  }

  return (
    <form onSubmit={(e) => addTodo(e)}>
      <input type="text" name="text" id="text" placeholder="Todo text" onChange={handleFieldChange} />
      <input type="text" name="description" id="description" placeholder="Todo description" onChange={handleFieldChange} />
      <button type="submit">{addTodoText}</button>
    </form>
  )
}

export { AddTodo };