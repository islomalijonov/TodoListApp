//
//  TodoService.swift
//  TodoListApp
//
//  Created by Islomjon Alijonov on 27/02/25.
//

import Foundation

class TodoService {
    private let network = Network.shared
    
    func getTodos(success successCallback: @escaping (Data) -> Void, error errorCallback: @escaping (AppError) -> Void) {
        _ = network.request(target: TodosAPI.getTodos, success: successCallback, error: errorCallback)
    }
}
