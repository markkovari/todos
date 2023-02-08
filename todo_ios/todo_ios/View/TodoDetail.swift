//
//  Todo.swift
//  todo_ios
//
//  Created by Mark Kovari on 2023. 02. 08..
//

import Foundation
import SwiftUI

struct TodoDetail: View {
    
    var todo: FetchedResults<Todo>.Element
    var paddingBase: CGFloat = 24.0
    
    var body: some View {
        HStack {
            GroupBox(todo.title!) {
                HStack {
                    Text("created:")
                    Text(todo.timestamp!, formatter: itemFormatter)
                }
                HStack {
                    Text("due:")
                    Text(todo.dueDate!, formatter: itemFormatter)
                }
            }
        }
        Spacer()
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
