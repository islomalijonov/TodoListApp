//
//  UsersAPI.swift
//  TodoListApp
//
//  Created by Islomjon Alijonov on 27/02/25.
//

import Foundation
import Moya

enum UsersAPI {
    case getUsers
}

extension UsersAPI: TargetType {
    var baseURL: URL {
        AppURL.baseURL
    }
    
    var path: String {
        switch self {
        case .getUsers:
            return "users"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Moya.Task {
        return .requestPlain
    }
    
    var headers: [String: String]? {
        return [
            "X-OS-VERSION": "\(UIDevice.current.systemName) \(UIDevice.current.systemVersion)",
            "X-DEVICE": UIDevice.current.identifierForVendor?.uuidString ?? "",
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    }
}
