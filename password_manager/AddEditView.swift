//
//  AddEditView.swift
//  password_manager
//
//  Created by Jay on 15/07/24.
//

import SwiftUI

struct AddEditPasswordView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: PasswordViewModel
    
    var entry: PasswordEntry?
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isSecured: Bool = true
    
    var body: some View {
        Form {
            Section(header: Text("Account Details")) {
                TextField("Account Name", text: $name)
                TextField("Username / Email", text: $email)
                ZStack(alignment: .trailing) {
                    Group {
                        if isSecured {
                            SecureField("Password", text: $password)
                        } else {
                            TextField("Password", text: $password)
                        }
                    }.padding(.trailing, 32)
                    
                    Button (action: {
                        isSecured.toggle()
                    }) {
                        Image(systemName: self.isSecured ? "eye.slash" : "eye")
                            .accentColor(.gray)
                    }
                }
                
            }
            
            HStack(spacing: 0) {
                Button(action: {
                    if let entry = entry {
                        viewModel.updateEntry(entry: entry, name: name, email: email, password: password)
                    } else {
                        viewModel.addEntry(name: name, email: email, password: password)
                    }
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text(entry == nil ? "Add New Account" : "Edit")
                }.foregroundColor(.white)
                    .frame(width: 150, height: 40)
                    .background(Color.black)
                    .cornerRadius(10)
                    .padding()
                
                if let entry = entry {
                    Button(action: {
                        if let index = viewModel.entries.firstIndex(where: { $0.id == entry.id }) {
                            viewModel.entries.remove(at: index)
                        }
//                            viewModel.deleteEntry(at: IndexSet)
                    }) {
                        Text("Delete")
                            .foregroundColor(.white)
                            .frame(width: 150, height: 40)
                            .background(Color.red)
                            .cornerRadius(10)
                            .padding()
                    }
                }
                
            }
            
            
        }
        .onAppear {
            if let entry = entry {
                name = entry.name
                email = entry.email
                password = entry.password
            }
        }
    }
}
