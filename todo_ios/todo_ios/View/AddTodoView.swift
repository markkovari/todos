//
//  AddTodoView.swift
//  todo_ios
//
//  Created by Mark Kovari on 2023. 02. 08..
//

import SwiftUI

struct AddTodoView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State var title = ""
    var titleText: String = "Title"
    
    @State var description = ""
    var descriptionText: String = "Description"
    
    @State var dueDate = Date.now
    var dueDateText: String = "Due Date"
    
    @State var isDone = false
    var isDoneText: String = "Is done"
    
    var addButtonText: String = "Add"

    var body: some View {
        Form {
            TextField(text: $title) {
                Text(titleText)
            }
            TextField(text: $description) {
                Text(descriptionText)
            }
            DatePicker(selection: $dueDate) {
                Text(dueDateText)
            }
            Toggle(isOn: $isDone) {
                Text("IsDone")
            }
            HStack {
                Button(addButtonText) {
                    addFromForm()
                }
                .frame(maxWidth: .infinity)
                .tint(.blue)
                .disabled(!canAdd())
            }
        }
        .formStyle(GroupedFormStyle())
    }
    
    private func addFromForm() {
        self.addItem(description: description, title: title, dueDate: dueDate)
    }
    
    private func addItem(description:String, title:String, dueDate: Date) {
        withAnimation {
            let newTodo = Todo(context: viewContext)
            newTodo.timestamp = Date()
            newTodo.desc = description
            newTodo.title = title
            newTodo.dueDate = dueDate
            newTodo.isDone = false
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            dismiss()
        }
    }
    
    private func canAdd() -> Bool {
        return !title.isEmpty && !description.isEmpty && dueDate >= Date.now
    }
}

struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AddTodoView()
        }
    }
}
