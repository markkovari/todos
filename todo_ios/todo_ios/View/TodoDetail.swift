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
    
    var body: some View {
        Text(todo.title ?? "")
    }
}
