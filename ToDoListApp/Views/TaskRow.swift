//
//  TaskRow.swift
//  ToDoListApp
//
//  Created by Narayana Wijaya on 31/07/23.
//

import SwiftUI
import CoreData

struct TaskRow: View {
    var item: Item
    
    var body: some View {
        HStack(alignment: .center) {
            Button {
                print("tap")
            } label: {
                Image(systemName: item.isComplete ?  "checkmark.circle.fill" : "circle")
            }
            .padding()
            .tint(.gray)

            NavigationLink {
                TaskDetailView(item: item)
            } label: {
                VStack(alignment: .leading) {
                    Text(item.title ?? "title")
                        .font(.title3)
                    Text(item.desc ?? "description")
                        .font(.subheadline)
                }
            }
            
        }
    }
}

struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        TaskRow(item: Item(context: viewContext))
    }
}
