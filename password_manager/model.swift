//
//  model.swift
//  password_manager
//
//  Created by Jay on 15/07/24.
//

import Foundation

struct PasswordEntry: Identifiable {
    var id = UUID()
    var name: String
    var email: String
    var password: String
}

