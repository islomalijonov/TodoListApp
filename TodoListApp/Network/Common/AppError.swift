//
//  AppError.swift
//  TodoListApp
//
//  Created by Islomjon Alijonov on 26/02/25.
//

import Foundation

struct AppError: Error, Decodable {
    var message: String?
    var responseCode: Int?
    var code: Int?
    var entityName: String?
    var errorKey: String?
    var type: String?
    var title: String?
    var status: Int?
    var params: String?
    
    static func unknown() -> AppError {
        return AppError(message: "Unknown error")
    }
}
