//
//  AddTaskFormView.swift
//  ToDoListApp
//
//  Created by Narayana Wijaya on 31/07/23.
//

import SwiftUI

struct AddTaskFormView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var date: Date = Date()
    
    var body: some View {
        Form {
            Section {
                TextField("Title", text: $title)
                TextField("Description", text: $description)
                DatePicker("Due Date", selection: $date)
            }
            
            Section {
                Button("Submit") {
                    withAnimation {
                        let task = Item(context: moc)
                        task.id = UUID()
                        task.title = title
                        task.desc = description
                        task.dueDate = date
                        
                        if moc.hasChanges {
                            do {
                                try moc.save()
                            } catch {
                                let nsError = error as NSError
                                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                            }
                        }
                    }
                    dismiss()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .tint(Color.blue)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.blue, lineWidth: 1)
                }
            }
        }
    }
}

struct AddTaskFormView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskFormView()
    }
}
