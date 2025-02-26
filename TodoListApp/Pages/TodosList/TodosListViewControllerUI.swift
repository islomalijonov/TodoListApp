//
//  TodosListViewControllerUI.swift
//  TodoListApp
//
//  Created by Islomjon Alijonov  on 26/02/25.
//  

import UIKit
import SnapKit

fileprivate protocol TodosListViewControllerInstaller: ViewInstaller {
    var containerView: UIView! {get set}
    var searchBar: UISearchBar! {get set}
    var tableView: UITableView! {get set}
}

extension TodosListViewControllerInstaller{
    func initSubviews() {
        containerView = {
            let view = UIView()
            view.backgroundColor = .systemGray6
            return view
        }()
        
        searchBar = {
            let searchBar = UISearchBar()
            searchBar.placeholder = "Search Todos"
            searchBar.backgroundImage = UIImage()
            searchBar.scopeButtonTitles = ["All", "Completed", "Not Completed"]
            searchBar.showsScopeBar = true
            return searchBar
        }()
        
        tableView = {
            let tableView = UITableView()
            tableView.backgroundColor = .clear
            tableView.separatorStyle = .none
            return tableView
        }()
    }
    
    func embedSubviews() {
        mainView.addSubview(containerView)
        containerView.addSubview(searchBar)
        containerView.addSubview(tableView)
    }
    
    func addSubviewsConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalTo(mainView.safeAreaLayoutGuide)
            make.left.right.bottom.equalToSuperview()
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
}

class TodosListViewControllerUI: BaseViewController, TodosListViewControllerInstaller {
    var searchBar: UISearchBar!
    
    var tableView: UITableView!
    
    var containerView: UIView!
    
    var parameter: Any?
    
    var mainView: UIView { view }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        
    }
}
