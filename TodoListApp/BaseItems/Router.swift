//
//  Router.swift
//  TodoListApp
//
//  Created by Islomjon Alijonov on 26/02/25.
//

import UIKit

protocol Router {
    associatedtype RouteType
    
    func route(
        to routeID: RouteType,
        from context: UIViewController
    )
}
