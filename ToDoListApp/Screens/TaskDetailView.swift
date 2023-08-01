//
//  TaskDetailView.swift
//  ToDoListApp
//
//  Created by Narayana Wijaya on 01/08/23.
//

import SwiftUI

struct TaskDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var isComplete: Bool = false
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var date: Date = Date()
    @State private var isEditing: Bool = false
    
    @ObservedObject var item: Item
    
    init(item: Item) {
        self.item = item
        _isComplete = State(initialValue: item.isComplete)
        _title = State(initialValue: item.title ?? "")
        _description = State(initialValue: item.desc ?? "")
        _date = State(initialValue: item.dueDate ?? Date())
    }
    
    var body: some View {
        Form {
            Section("Title") {
                TextField("", text: $title)
                    .disabled(!isEditing)
            }
            Section("Description") {
                TextField("", text: $description, axis: .vertical)
                    .font(.subheadline)
                    .disabled(!isEditing)
                    .lineLimit(4)
                    .multilineTextAlignment(.leading)
                    .frame(height: 100, alignment: .top)
            }
            Section {
                DatePicker("Due date", selection: $date)
                    .disabled(!isEditing)
                Toggle("Set as complete", isOn: $isComplete)
                    .onChange(of: isComplete, perform: { newValue in
                        item.isComplete = newValue
                        try? viewContext.save()
                    })
                    .toggleStyle(.switch)
            }
        }
        .toolbar {
            ToolbarItem {
                Button(!isEditing ? "Edit": "Update") {
                    if isEditing {
                        update()
                    }
                    isEditing.toggle()
                }
            }
        }
    }
    
    private func update() {
        item.title = title
        item.desc = description
        item.dueDate = date
        try? viewContext.save()
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        TaskDetailView(item: Item(context: viewContext))
    }
}
