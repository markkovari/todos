//
//  Todo.swift
//  todo_ios
//
//  Created by Mark Kovari on 2023. 02. 08..
//

import Foundation
import SwiftUI

struct TodoDetail: View {
    
    @ObservedObject var todo: Todo
    var paddingBase: CGFloat = 24.0
    
    @State var isSheetOpen = false
    
    var body: some View {
        Group {
            VStack {
                HStack {
                    Text(todo.title ?? "")
                    Spacer()
                    Image(systemName: todo.isDone ? "checkmark.seal.fill" : "checkmark.seal")
                }
                Spacer()
                HStack {
                    Text("description")
                    Spacer()
                    Text(todo.desc ?? "")
                }
                Spacer()
                HStack {
                    Text("created")
                    Spacer()
                    Text(todo.timestamp ?? Date.now, formatter: itemFormatter)
                }
                Spacer()
                HStack {
                    Text("due")
                    Spacer()
                    Text(todo.dueDate ?? Date.now, formatter: itemFormatter)
                }
                Spacer()
                NavigationLink {
                    TodoEditor(todo: todo)
                } label: {
                    Text("Edit")
                }
            }
            .frame(maxHeight: 240)
            Spacer()
        }
    }
}

struct TodoDetailPreview: PreviewProvider {
    
    static let persistence = PersistenceController.preview
    
    static var doneExample: Todo = {
        let context = persistence.container.viewContext
        let todo = Todo(context: context)
        todo.id = UUID()
        todo.timestamp = Date()
        todo.dueDate = Date.now.addingTimeInterval(60*60*24)
        todo.title = "Some done todo"
        todo.desc = "Some description"
        todo.isDone = true
        return todo
    }()
    
    static var unDoneExample: Todo = {
        let context = persistence.container.viewContext
        let todo = Todo(context: context)
        todo.id = UUID()
        todo.timestamp = Date()
        todo.dueDate = Date.now
        todo.title = "Some undone todo"
        todo.isDone = false
        return todo
    }()
    
    static var previews: some View {
        TodoDetail(todo: doneExample)
            .environment(\.managedObjectContext, persistence.container.viewContext)
    }
}
