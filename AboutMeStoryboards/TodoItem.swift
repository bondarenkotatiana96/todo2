//
//  TodoItem.swift
//  AboutMeStoryboards
//
//  Created by user on 11/11/23.
//

import Foundation

struct TodoItem {
    var name: String
    var isCompleted: Bool = false
    var id: UUID = UUID()
}
