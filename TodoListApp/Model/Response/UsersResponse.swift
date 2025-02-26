//
//  UsersResponse.swift
//  TodoListApp
//
//  Created by Islomjon Alijonov on 27/02/25.
//

struct UsersResponse: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
    
    static let unknown = UsersResponse(
        id: -1,
        name: "Unknown User",
        username: "unknown",
        email: "unknown@example.com",
        address: Address.unknown,
        phone: "N/A",
        website: "N/A",
        company: Company.unknown
    )
}

struct Address: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
    
    static let unknown = Address(
        street: "Unknown",
        suite: "Unknown",
        city: "Unknown",
        zipcode: "00000",
        geo: Geo.unknown
    )
}

struct Geo: Codable {
    let lat: String
    let lng: String
    
    static let unknown = Geo(lat: "0.0", lng: "0.0")
}

struct Company: Codable {
    let name: String
    let catchPhrase: String
    let bs: String
    
    static let unknown = Company(name: "Unknown", catchPhrase: "N/A", bs: "N/A")
}
