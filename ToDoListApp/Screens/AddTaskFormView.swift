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
        VStack {
            Form {
                Section {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description)
                    DatePicker("Due Date", selection: $date)
                }
            }
            Button {
                saveTask()
            } label: {
                Text("SAVE")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50, alignment: .center)
                    .background(.blue)
                    .cornerRadius(12)
                    .padding()
            }
        }
        .background(.red)
    }
    
    private func saveTask() {
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
}

struct AddTaskFormView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskFormView()
    }
}
