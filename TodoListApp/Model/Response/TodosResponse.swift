//
//  TodosResponse.swift
//  TodoListApp
//
//  Created by Islomjon Alijonov on 27/02/25.
//

import Foundation

struct TodosResponse: Codable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}
