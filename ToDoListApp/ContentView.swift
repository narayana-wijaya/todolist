//
//  ContentView.swift
//  ToDoListApp
//
//  Created by Narayana Wijaya on 31/07/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var moc
    @State private var showAddForm = false

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.id, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @EnvironmentObject private var errorState: ErrorState

    var body: some View {
        NavigationView {
            List {
                ForEach(items.sorted { !$0.isComplete && $1.isComplete }) { item in
                    TaskRow(item: item)
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Todo List")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItem {
                    NavigationLink {
                        AddTaskFormScreen()
                    } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
        .environmentObject(errorState)
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(moc.delete)

            do {
                try moc.save()
            } catch {
                let nsError = error as NSError
                errorState.errorWrapper = ErrorWrapper(
                    error: .failDeleteObject,
                    description: "Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PreviewData.listPreview.container.viewContext)
    }
}
