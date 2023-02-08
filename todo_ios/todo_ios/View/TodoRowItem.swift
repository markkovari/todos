//
//  TodoRowItem.swift
//  todo_ios
//
//  Created by Mark Kovari on 2023. 02. 08..
//

import SwiftUI

struct TodoRowItem: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var todo: Todo
    
    var body: some View {
        HStack {
            Text(todo.title ?? "")
                .strikethrough(todo.isDone)
            Spacer()
            Text("\(timeLeft(todo.dueDate).0) days, \(timeLeft(todo.dueDate).1) hours")
        }
        .swipeActions(edge: .leading, allowsFullSwipe: true) {
            Button {
                toggleTodo(todo: todo)
            } label: {
                Image(systemName: "checkmark")
            }
            .tint(todo.isDone ? .teal: .green)
        }
    }
    
    private func getHoursLeft(date: Date, until: Date) -> Int {
        if date < until {
            return 0
        }
        return Int(until.distance(to: date) / (60 * 60))
    }
    
    private func timeLeft(_ date: Date?) -> (Int, Int) {
        let hoursLeft = getHoursLeft(date: date ?? Date.now, until: Date.now)
        return (hoursLeft / 24, hoursLeft % 24)
    }
    
    private func toggleTodo(todo: Todo) {
        withAnimation {
            todo.isDone.toggle()
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}


struct TodoRowItemPreview: PreviewProvider {
    
    static let persistence = PersistenceController.preview
    
    static var doneExample: Todo = {
        let context = persistence.container.viewContext
        let todo = Todo(context: context)
        todo.timestamp = Date()
        todo.dueDate = Date.now.addingTimeInterval(20*60*60*24)
        todo.title = "Some done todo"
        todo.isDone = true
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
            TodoRowItem(todo: doneExample)
            Spacer()
            TodoRowItem(todo: unDoneExample)
            Spacer()
            
        }
        .environment(\.managedObjectContext, persistence.container.viewContext)
    }
}
