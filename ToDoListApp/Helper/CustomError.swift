//
//  CustomError.swift
//  ToDoListApp
//
//  Created by Narayana Wijaya on 02/08/23.
//

import Foundation

struct ErrorWrapper: Identifiable {
    var id = UUID()
    let error: CustomError
    let description: String
}

enum CustomError: Error, CustomStringConvertible {
    case emptyField
    case failSaveObject
    case failDeleteObject
    
    var description: String {
        switch self {
        case .emptyField:
            return "Field is empty"
        case .failSaveObject:
            return "Failed to save data"
        case .failDeleteObject:
            return "Failed to delete item"
        }
    }
}

class ErrorState: ObservableObject {
    @Published var errorWrapper: ErrorWrapper?
}
