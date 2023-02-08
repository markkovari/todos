//
//  Todo.swift
//  todo_ios
//
//  Created by Mark Kovari on 2023. 02. 08..
//

import Foundation
import SwiftUI

struct TodoDetail: View {
    
    @State var todo: Todo
    var paddingBase: CGFloat = 24.0
    
    var body: some View {
        HStack {
            GroupBox(todo.title!) {
                Spacer()
                HStack {
                    Text("created:")
                    Spacer()
                    Text(todo.timestamp!, formatter: itemFormatter)
                }
                Spacer()
                HStack {
                    Text("due:")
                    Spacer()
                    Text(todo.dueDate!, formatter: itemFormatter)
                }
                Toggle("DONE", isOn: $todo.isDone)
                    .disabled(true)
            }
        }
    }
}

struct TodoDetailPreview: PreviewProvider {
    
    static let persistence = PersistenceController.preview
    
    static var doneExample: Todo = {
        let context = persistence.container.viewContext
        let todo = Todo(context: context)
        todo.timestamp = Date()
        todo.dueDate = Date.now.addingTimeInterval(60*60*24)
        todo.title = "Some done todo"
        todo.isDone = true
        return todo
    }()
    
    static var unDoneExample: Todo = {
        let context = persistence.container.viewContext
        let todo = Todo(context: context)
        todo.timestamp = Date()
        todo.dueDate = Date.now
        todo.title = "Some undone todo"
        todo.isDone = false
        return todo
    }()
    
    static var previews: some View {
        VStack {
            Spacer()
            TodoDetail(todo: doneExample)
            Spacer()
            TodoDetail(todo: unDoneExample)
            Spacer()
            
        }
        .environment(\.managedObjectContext, persistence.container.viewContext)
        
    }
}
