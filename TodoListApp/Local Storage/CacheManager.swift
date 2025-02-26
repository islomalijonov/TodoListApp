//
//  CacheManager.swift
//  TodoListApp
//
//  Created by Islomjon Alijonov on 27/02/25.
//

import Foundation

class CacheManager {
    
    static let shared = CacheManager()
    
    private init() {}
    
    func save<T: Codable>(key: String, data: T) {
        do {
            let encodedData = try JSONEncoder().encode(data)
            UserDefaults.standard.set(encodedData, forKey: key)
        } catch {
            print("❌ Error caching data for \(key): \(error.localizedDescription)")
        }
    }
    
    func load<T: Codable>(key: String, type: T.Type) -> T? {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            print("⚠️ No cached data found for \(key).")
            return nil
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("❌ Error decoding cached data for \(key): \(error.localizedDescription)")
            return nil
        }
    }
}
