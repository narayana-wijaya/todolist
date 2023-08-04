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
    
    @StateObject private var model = TaskDataModel()
    @EnvironmentObject private var errorState: ErrorState
    
    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("Title", text: $model.title)
                    TextField("Description", text: $model.description, axis: .vertical)
                        .lineLimit(4)
                        .multilineTextAlignment(.leading)
                        .frame(height: 100, alignment: .top)
                    DatePicker("Due Date",
                               selection: $model.date,
                               in: Date()...)
                }
            }
            Button {
                saveToLocal()
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
        .environmentObject(errorState)
    }
    
    private func saveToLocal() {
        guard model.isValid() else {
            errorState.errorWrapper = ErrorWrapper(error: .emptyField, description: "Please fill the empty field")
            return
        }
        
        let task = Item(context: moc)
        model.create(task: task)
        if moc.hasChanges {
            do {
                try moc.save()
            } catch {
                let nsError = error as NSError
                errorState.errorWrapper = ErrorWrapper(
                    error: .failSaveObject,
                    description: "Unresolved error \(nsError), \(nsError.userInfo)")
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
