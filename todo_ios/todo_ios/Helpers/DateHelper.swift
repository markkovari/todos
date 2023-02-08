//
//  DateHelper.swift
//  todo_ios
//
//  Created by Mark Kovari on 2023. 02. 08..
//

import Foundation


let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
