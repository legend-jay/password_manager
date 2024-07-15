//
//  viewModel.swift
//  password_manager
//
//  Created by Jay on 15/07/24.
//

import Foundation

class PasswordViewModel: ObservableObject {
    @Published var entries: [PasswordEntry] = []
    
    func addEntry(name:String, email:String, password:String) {
        let newEntry = PasswordEntry(name: name, email: email, password: password)
        entries.append(newEntry)
    }
    
    func deleteEntry(at offsets: IndexSet) {
        entries.remove(atOffsets: offsets)
    }
    
    func updateEntry(entry:PasswordEntry, name:String, email:String, password:String) {
        if let index = entries.firstIndex(where: { $0.id == entry.id }) {
            entries[index].name = name
            entries[index].email = email
            entries[index].password = password
        }
    }
    
}
