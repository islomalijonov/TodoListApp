//
//  TodoDetailsViewController.swift
//  TodoListApp
//
//  Created by Islomjon Alijonov  on 26/02/25.
//

import UIKit

class TodoDetailsViewController: TodoDetailsViewControllerUI {
    
    let router = TodoDetailsRouter()
    let viewModel = TodoDetailsViewModel()
    let refreshControl = UIRefreshControl()
    let todo: TodosResponse
    let user: UsersResponse
    
    init(todo: TodosResponse, user: UsersResponse) {
        self.todo = todo
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Todo Details"
        setupData()
    }
    
    func setupData() {
        titleLabel.text = "📌 Title: \(todo.title)"
        completedLabel.text = todo.completed ? "✅ Completed" : "❌ Not Completed"
        completedLabel.textColor = todo.completed ? .green : .red
        
        userNameLabel.text = "👨‍💼 Name: \(user.name)"
        userEmailLabel.text = "📧 Email: \(user.email)"
        userPhoneLabel.text = "📞 Phone: \(user.phone)"
        userWebsiteLabel.text = "🌐 Website: \(user.website)"
        userAddressLabel.text = "📍 Address: \(user.address.street), \(user.address.suite), \(user.address.city), \(user.address.zipcode)"
        userCompanyLabel.text = "🏢 Company: \(user.company.name)"
    }
}
