//
//  TaskDataModel.swift
//  ToDoListApp
//
//  Created by Narayana Wijaya on 03/08/23.
//

import Foundation

class TaskDataModel: ObservableObject {
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var date: Date = Date()
    
    @Published var isError: Bool = false
    @Published var error: CustomError?
    
    @Published var item: Item!
    
    init(item: Item? = nil) {
        guard let item = item else { return }
        self.item = item
        
        _title = Published(initialValue: item.title ?? "")
        _description = Published(initialValue: item.desc ?? "")
        _date = Published(initialValue: item.dueDate ?? Date())
    }
    
    func isValid() -> Bool {
        isError = title.isEmpty && description.isEmpty
        if isError {
            error = .emptyField
        }
        
        return !isError
    }
    
    func create(task: Item) {
        task.id = UUID()
        task.title = title
        task.desc = description
        task.dueDate = date
    }
    
    func update() {
        item.title = title
        item.desc = description
        item.dueDate = date
    }
    
    func setTaskStatus(complete: Bool) {
        item.isComplete = complete
    }
}
