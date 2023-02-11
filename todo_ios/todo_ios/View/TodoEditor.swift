//
//  TodoEditor.swift
//  todo_ios
//
//  Created by Mark Kovari on 2023. 02. 09..
//

import SwiftUI

struct TodoEditor: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var todo: Todo
    

    @State var title: String
    @State var description: String
    @State var isDone: Bool
    @State var dueDate: Date
    
    init(todo: Todo) {
        self.todo = todo
        self._title = State(initialValue: todo.title ?? "")
        self._description = State(initialValue: todo.desc ?? "")
        self._isDone = State(initialValue: todo.isDone)
        self._dueDate = State(initialValue: todo.dueDate ?? Date.now)
    }
    
    var body: some View {
        Form {
            TextField(text: $title) {
                Text("title")
            }
            TextField(text: $description) {
                Text("description")
            }
            DatePicker(selection: $dueDate) {
                Text("Due date")
            }
            Toggle(isOn: $isDone) {
                Text("is done")
            }
            HStack {
                Button("Cancel") {
                    dismiss()
                }
                Spacer()
                Button("Update") {
                    updateTodo()
                }
            }
        }
    }
    
    private func updateTodo() {
        todo.title = title
        todo.desc = description
        todo.dueDate = dueDate
        try? managedObjectContext.save()
    }
}

struct TodoEditor_Previews: PreviewProvider {
    
    static let persistence = PersistenceController.preview
    
    static var doneExample: Todo = {
        let context = persistence.container.viewContext
        let todo = Todo(context: context)
        todo.timestamp = Date()
        todo.dueDate = Date.now.addingTimeInterval(20*60*60*24)
        todo.title = "Some done todo"
        todo.isDone = true
        todo.desc = "some description"
        return todo
    }()
    
    static var unDoneExample: Todo = {
        let context = persistence.container.viewContext
        let todo = Todo(context: context)
        todo.timestamp = Date()
        todo.dueDate = Date.now.advanced(by: -24*60*60*2)
        todo.title = "Some undone todo"
        todo.isDone = false
        return todo
    }()
    
    static var previews: some View {
        VStack {
            Spacer()
            TodoEditor(todo: doneExample)
            Spacer()
            TodoEditor(todo: unDoneExample)
            Spacer()
            
        }
        .environment(\.managedObjectContext, persistence.container.viewContext)
    }
}
