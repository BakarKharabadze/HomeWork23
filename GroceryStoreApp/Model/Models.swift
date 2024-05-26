//
//  Models.swift
//  GroceryStoreApp
//
//  Created by Bakar Kharabadze on 5/26/24.
//

import Foundation

struct Products {
    let type: String
    let name: String
    let price: Double
    var quantity: Int
    let image: String
    let id = UUID()
    
    static var allProducts: [Products] = [
        Products(type: "Fruit", name: "ბანანი", price: 1.50, quantity: 10, image: "🍌"),
        Products(type: "Fruit", name: "ვაშლი", price: 1.0, quantity: 20, image: "🍏"),
        Products(type: "Fruit", name: "საზამთრო", price: 2.0, quantity: 5, image: "🍉"),
        Products(type: "Vegetable", name: "პომიდორი", price: 3.50, quantity: 15, image: "🍅"),
        Products(type: "Vegetable", name: "კარტოფილი", price: 1.0, quantity: 10 , image: "🥔"),
        Products(type: "Vegetable", name: "ბროკოლი", price: 3.50, quantity: 11, image: "🥦")
    ]
    
}
