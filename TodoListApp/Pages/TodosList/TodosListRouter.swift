//
//  TodosListRouter.swift
//  TodoListApp
//
//  Created by Islomjon Alijonov  on 26/02/25.
//  

import UIKit

enum TodosListIdentifiers {
    case todoDetails(todo: TodosResponse, user: UsersResponse)
}

class TodosListRouter: Router {
    func route(to routeID: TodosListIdentifiers, from context: UIViewController) {
        switch routeID {
        case .todoDetails(let todo, let user):
            let todoDetailsVC = TodoDetailsViewController(todo: todo, user: user)
            context.navigationController?.pushViewController(todoDetailsVC, animated: true)
        }
    }
}
