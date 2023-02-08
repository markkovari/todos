//
//  ContentView.swift
//  todo_ios
//
//  Created by Mark Kovari on 2023. 02. 08..
//

import SwiftUI
import CoreData

struct ContentView: View {
    private var title: String = "Todos"
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Todo.timestamp, ascending: true)],
        animation: .default)
    private var todos: FetchedResults<Todo>
    
    @State var isSheetOpen: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(todos) { todo in
                    NavigationLink {
                        TodoDetail(todo: todo)
                    } label: {
                        Text("Item at \(todo.timestamp!, formatter: itemFormatter)")
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button{
                        isSheetOpen = true
                    } label: {
                        Image(systemName: "plus.app")
                    }
                }
            }
        }
        .navigationTitle(title)
        .sheet(isPresented: $isSheetOpen) {
            AddTodoView()
        }
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
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { todos[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
