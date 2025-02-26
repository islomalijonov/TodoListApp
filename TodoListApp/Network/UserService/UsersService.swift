//
//  UsersService.swift
//  TodoListApp
//
//  Created by Islomjon Alijonov on 27/02/25.
//

import Foundation

class UsersService {
    private let network = Network.shared
    
    func getUsers(success successCallback: @escaping (Data) -> Void, error errorCallback: @escaping (AppError) -> Void) {
        _ = network.request(target: UsersAPI.getUsers, success: successCallback, error: errorCallback)
    }
}
