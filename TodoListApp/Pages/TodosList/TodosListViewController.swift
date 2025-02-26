//
//  TodosListViewController.swift
//  TodoListApp
//
//  Created by Islomjon Alijonov  on 26/02/25.
//  

import UIKit

class TodosListViewController: TodosListViewControllerUI, UISearchBarDelegate {
    let router = TodosListRouter()
    let viewModel = TodosListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "To Do List"
        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: "TodoTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
        searchBar.returnKeyType = .done
        addKeyboardToolbar(to: searchBar)
        setupBindings()
        fetchData()
    }
    
    func setupBindings() {
        viewModel.onDataUpdate = { [weak self] in
            self?.tableView.reloadData()
            self?.tableView.tableFooterView = self?.viewModel.isLoadingMore == true ? self?.loadingFooter() : nil
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 1:
            viewModel.applyFilter(.completed)
        case 2:
            viewModel.applyFilter(.notCompleted)
        default:
            viewModel.applyFilter(.all)
        }
    }
    
    func loadingFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        let loadingLabel = UILabel(frame: footerView.bounds)
        loadingLabel.text = "Please wait..."
        loadingLabel.textAlignment = .center
        loadingLabel.textColor = .gray
        loadingLabel.font = UIFont.systemFont(ofSize: 14)
        footerView.addSubview(loadingLabel)
        return footerView
    }
    
    func fetchData() {
        showProgressHUD()
        
        viewModel.fetchTodosAndUsers { [weak self] in
            self?.hideProgressHUD()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        viewModel.filterTodos(by: searchBar.text)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterTodos(by: searchText)
    }
}

extension TodosListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredTodos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoTableViewCell", for: indexPath) as! TodoTableViewCell
        cell.selectionStyle = .none
        
        let todo = viewModel.filteredTodos[indexPath.row]
        let userName = viewModel.users.first(where: { $0.id == todo.userId })?.name ?? "Unknown User"
        
        cell.configure(userName: userName, todoTitle: todo.title)
        
        if indexPath.row == viewModel.filteredTodos.count - 1 {
            viewModel.loadMoreTodos()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTodo = viewModel.filteredTodos[indexPath.row]
        let selectedUser = viewModel.users.first(where: { $0.id == selectedTodo.userId }) ?? .unknown
        
        router.route(to: .todoDetails(todo: selectedTodo, user: selectedUser), from: self)
    }
}
