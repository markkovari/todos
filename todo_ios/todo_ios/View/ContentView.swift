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
                        TodoRowItem(todo: todo)
                    }
                }
                .onDelete(perform: deleteItems)
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isSheetOpen.toggle()
                    } label: {
                        Image(systemName: "plus.app")
                    }
                }
            }
            .navigationTitle(title)
            
        }
        .sheet(isPresented: $isSheetOpen) {
            AddTodoView()
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { todos[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
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
