//
//  CustomError.swift
//  ToDoListApp
//
//  Created by Narayana Wijaya on 02/08/23.
//

import Foundation

enum CustomError: LocalizedError {
    case emptyField
    
    var errorDescription: String? {
        switch self {
        case .emptyField: return "Please fill the empty field"
        }
    }
}
