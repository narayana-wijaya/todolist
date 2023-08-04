//
//  TaskDetailView.swift
//  ToDoListApp
//
//  Created by Narayana Wijaya on 01/08/23.
//

import SwiftUI

struct TaskDetailScreen: View {
    @Environment(\.managedObjectContext) private var moc
    
    @State private var isEditing: Bool = false
    @StateObject private var model: TaskDataModel
    @EnvironmentObject private var errorState: ErrorState
    
    init(item: Item) {
        _model = StateObject(wrappedValue: TaskDataModel(item: item))
    }
    
    var body: some View {
        Form {
            Section("Title") {
                TextField("", text: $model.title) // $model.item.title produce error
                    .disabled(!isEditing)
            }
            Section("Description") {
                TextField("", text: $model.description, axis: .vertical)
                    .font(.subheadline)
                    .disabled(!isEditing)
                    .lineLimit(4)
                    .multilineTextAlignment(.leading)
                    .frame(height: 100, alignment: .top)
            }
            Section {
                DatePicker("Due date", selection: $model.date)
                    .disabled(!isEditing)
                Toggle("Set as complete", isOn: $model.item.isComplete)
                    .onChange(of: model.item.isComplete, perform: { newValue in
                        saveLocally()
                    })
                    .toggleStyle(.switch)
            }
        }
        .toolbar {
            ToolbarItem {
                Button(!isEditing ? "Edit": "Update") {
                    if isEditing {
                        model.update()
                        saveLocally()
                    }
                    isEditing.toggle()
                }
            }
        }
        .environmentObject(errorState)
    }
    
    private func saveLocally() {
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
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailScreen(item: PreviewData.itemPreview)
    }
}
