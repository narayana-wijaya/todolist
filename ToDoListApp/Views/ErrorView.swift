//
//  ErrorView.swift
//  ToDoListApp
//
//  Created by Narayana Wijaya on 03/08/23.
//

import SwiftUI

struct ErrorView: View {
    @Environment(\.dismiss) var dismiss
    
    let errorWrapper: ErrorWrapper
    
    var body: some View {
        VStack {
            Spacer()
            Text("Error has occured.")
                .font(.headline)
                .padding([.bottom], 10)
            Image("error_ilustration")
                .resizable()
                .scaledToFit()
            Text(errorWrapper.error.description)
                .padding()
            Text(errorWrapper.description)
                .padding()
                .font(.caption)
                .multilineTextAlignment(.center)
            Spacer()
            Button("Close") {
                dismiss()
            }.buttonStyle(.borderless)
        }
        .padding()
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(errorWrapper: ErrorWrapper(error: CustomError.failSaveObject, description: "Please fix the error or something bad will happen to this world"))
    }
}
