//
//  TodosListViewModel.swift
//  TodoListApp
//
//  Created by Islomjon Alijonov  on 26/02/25.
//  

import UIKit
import Network

enum FilterType {
    case all, completed, notCompleted
}

class TodosListViewModel {
    
    private let todosCacheKey = "cachedTodos"
    private let usersCacheKey = "cachedUsers"
    private let networkMonitor = NWPathMonitor()
    
    var todos: [TodosResponse] = []
    var users: [UsersResponse] = []
    
    private(set) var filteredTodos: [TodosResponse] = []
    private var allFilteredTodos: [TodosResponse] = []
    
    private let pageSize = 20
    private var currentPage = 0
    private var isFetching = false
    private(set) var isLoadingMore = false
    
    let todoService = TodoService()
    let usersService = UsersService()
    
    var onDataUpdate: (() -> Void)?
    
    private var currentFilter: FilterType = .all
    
    init() {
        setupNetworkMonitor()
    }
    
    func setupNetworkMonitor() {
        networkMonitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            
            if path.status == .satisfied {
                self.fetchTodosAndUsers()
            } else {
                self.loadCachedTodos()
                self.loadCachedUsers()
            }
        }
        let queue = DispatchQueue(label: "NetworkMonitor")
        networkMonitor.start(queue: queue)
    }
    
    func fetchTodosAndUsers(completion: (() -> Void)? = nil) {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        fetchTodos {
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        fetchUsers {
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.applyFilter(self.currentFilter)
            self.cacheTodos()
            self.cacheUsers()
            self.onDataUpdate?()
            completion?()
        }
    }
    
    func fetchTodos(completion: (() -> Void)? = nil) {
        todoService.getTodos(success: { [weak self] (data) in
            let decoder = JSONDecoder()
            do {
                guard let self = self else { return }
                
                let response = try decoder.decode([TodosResponse].self, from: data)
                self.todos = response
                self.applyFilter(self.currentFilter)
                self.cacheTodos()
            } catch {
                print("❌ Decoding error for todos: \(error.localizedDescription)")
            }
            completion?()
        }, error: { error in
            print("❌ Error fetching todos: \(error)")
            completion?()
        })
    }
    
    func fetchUsers(completion: (() -> Void)? = nil) {
        usersService.getUsers(success: { [weak self] (data) in
            let decoder = JSONDecoder()
            do {
                guard let self = self else { return }
                
                let response = try decoder.decode([UsersResponse].self, from: data)
                self.users = response
                self.cacheUsers()
            } catch {
                print("❌ Decoding error for users: \(error.localizedDescription)")
            }
            completion?()
        }, error: { error in
            print("❌ Error fetching users: \(error)")
            completion?()
        })
    }
    
    func applyFilter(_ filter: FilterType) {
        currentFilter = filter
        switch filter {
        case .all:
            resetPagination(data: todos)
        case .completed:
            let completedTodos = todos.filter { $0.completed }
            resetPagination(data: completedTodos)
        case .notCompleted:
            let notCompletedTodos = todos.filter { !$0.completed }
            resetPagination(data: notCompletedTodos)
        }
    }
    
    func resetPagination(data: [TodosResponse]) {
        currentPage = 1
        allFilteredTodos = data
        filteredTodos = Array(data.prefix(pageSize))
        onDataUpdate?()
    }
    
    func loadMoreTodos() {
        guard !isFetching, !isLoadingMore else { return }
        guard currentPage * pageSize < allFilteredTodos.count else { return }
        
        isFetching = true
        isLoadingMore = true
        onDataUpdate?()
        
        let startIndex = currentPage * pageSize
        let endIndex = min(startIndex + pageSize, allFilteredTodos.count)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.filteredTodos.append(contentsOf: self.allFilteredTodos[startIndex..<endIndex])
            self.currentPage += 1
            
            self.isFetching = false
            self.isLoadingMore = false
            self.onDataUpdate?()
        }
    }
    
    func filterTodos(by searchText: String?) {
        guard let searchText = searchText, !searchText.isEmpty else {
            applyFilter(currentFilter)
            return
        }
        
        let lowercasedQuery = searchText.lowercased()
        
        let baseTodos: [TodosResponse]
        
        switch currentFilter {
        case .all:
            baseTodos = todos
        case .completed:
            baseTodos = todos.filter { $0.completed }
        case .notCompleted:
            baseTodos = todos.filter { !$0.completed }
        }
        
        let searchedTodos = baseTodos.filter { todo in
            let titleMatches = todo.title.lowercased().contains(lowercasedQuery)
            let userMatches = users.first(where: { $0.id == todo.userId })?.name.lowercased().contains(lowercasedQuery) ?? false
            return titleMatches || userMatches
        }
        
        resetPagination(data: searchedTodos)
    }
    
    func cacheTodos() {
        CacheManager.shared.save(key: todosCacheKey, data: todos)
    }
    
    func cacheUsers() {
        CacheManager.shared.save(key: usersCacheKey, data: users)
    }
    
    func loadCachedTodos() {
        if let cachedTodos: [TodosResponse] = CacheManager.shared.load(key: todosCacheKey, type: [TodosResponse].self) {
            self.todos = cachedTodos
            self.applyFilter(self.currentFilter)
        }
    }
    
    func loadCachedUsers() {
        if let cachedUsers: [UsersResponse] = CacheManager.shared.load(key: usersCacheKey, type: [UsersResponse].self) {
            self.users = cachedUsers
        }
    }
}
