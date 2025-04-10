//
//  Friend.swift
//  Birthdays
//
//  Created by Scholar on 4/10/25.
//

import Foundation
import SwiftData

@Model
class Friend {
    var name: String
    var birthday: Date
    
    init(name: String, birthday: Date) {
        self.name = name
        self.birthday = birthday
    }
}
