//
//  AddTaskFormView.swift
//  ToDoListApp
//
//  Created by Narayana Wijaya on 31/07/23.
//

import SwiftUI

struct AddTaskFormScreen: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var date: Date = Date()
    @State private var isError: Bool = false
    @State private var error: CustomError?
    
    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description)
                        .lineLimit(4)
                        .multilineTextAlignment(.leading)
                        .frame(height: 100, alignment: .top)
                    DatePicker("Due Date",
                               selection: $date,
                               in: Date()...)
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
        .alert(
            isPresented: $isError,
            error: error) {
                Button("Close") {
                    isError = false
                }
            }
    }
    
    private func saveTask() {
        guard !title.isEmpty && !description.isEmpty else {
            error = .emptyField
            isError = true
            return
        }
        
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
        AddTaskFormScreen()
    }
}
