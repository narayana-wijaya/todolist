//
//  PreviewData.swift
//  ToDoListApp
//
//  Created by Narayana Wijaya on 02/08/23.
//

import Foundation

struct PreviewData {
    static let shared = PreviewData()
    
    static var listPreview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for i in 0..<10 {
            let newItem = Item(context: viewContext)
            newItem.dueDate = Date()
            newItem.title = "Task \(i)"
            newItem.desc = "Task \(i) description"
            newItem.isComplete = true
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    static var itemPreview: Item {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        let newItem = Item(context: viewContext)
        newItem.dueDate = Date()
        newItem.title = "Task Example"
        newItem.desc = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
        newItem.isComplete = true
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return newItem
    }
}

