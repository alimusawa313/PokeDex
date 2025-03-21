//
//  User.swift
//  PokeDex
//
//  Created by Ali Haidar on 3/21/25.
//

import Foundation
import SwiftData

@Model
final class User {
    var name: String
    var email: String
    var password: String
    var dob: Date
    
    init(name: String, email: String, password: String, dob: Date) {
        self.name = name
        self.email = email
        self.password = password
        self.dob = dob
    }
}
