import { useState } from "react";
import { useTodoStore } from "../store";
import "./AddTodo.css";

function AddTodo() {
  const addTodoText = "Add todo";

  const { addTodo } = useTodoStore();

  const [fields, setFields] = useState({
    text: "",
    description: "",
  });

  function resetFields() {
    setFields({ text: "", description: "" });
  }

  function handleFieldChange(event: React.ChangeEvent<HTMLInputElement>) {
    const { name, value } = event.currentTarget;
    setFields({ ...fields, [name]: value });
  }

  function addTodoHandler(event: React.FormEvent<HTMLFormElement>) {
    event.preventDefault();
    if (!fields.text) return;
    if (!fields.description) return;
    addTodo({
      ...fields,
      isDone: false,
    });
    resetFields();
  }

  return (
    <form onSubmit={addTodoHandler}>
      <input
        type="text"
        name="text"
        id="text"
        placeholder="Todo text"
        onChange={handleFieldChange}
        value={fields.text}
      />
      <input
        type="text"
        name="description"
        id="description"
        placeholder="Todo description"
        onChange={handleFieldChange}
        value={fields.description}
      />
      <button type="submit">{addTodoText}</button>
    </form>
  );
}

export { AddTodo };
