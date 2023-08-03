//
//  TaskRow.swift
//  ToDoListApp
//
//  Created by Narayana Wijaya on 31/07/23.
//

import SwiftUI
import CoreData

struct TaskRow: View {
    @Environment(\.managedObjectContext) private var moc
    @ObservedObject var item: Item
    
    var body: some View {
        HStack(alignment: .center) {
            Button {
                item.isComplete.toggle()
                try? moc.save()
            } label: {
                Image(systemName: item.isComplete ?  "checkmark.circle.fill" : "circle")
            }
            .buttonStyle(.borderless)
            .tint(.gray)

            NavigationLink {
                TaskDetailScreen(item: item)
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
        TaskRow(item: PreviewData.itemPreview)
    }
}
