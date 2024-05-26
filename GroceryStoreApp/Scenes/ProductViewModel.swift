//
//  ProductViewModel.swift
//  GroceryStoreApp
//
//  Created by Bakar Kharabadze on 5/26/24.
//

import Foundation

class ProductViewModel: ObservableObject {
    //MARK: - Published Properties
    @Published var fruitSection: [Products] = []
    @Published var vegetableSection: [Products] = []
    @Published var cartItems: [Products] = []
    
    //MARK: - Computed Properties
    var totalQuantity: Int {
        cartItems.reduce(0) { $0 + $1.quantity }
    }
    
    var totalPrice: Double {
        cartItems.reduce(0) { $0 + $1.price * Double($1.quantity) }
    }
    
    //MARK: - Initialization
    init() {
        fetchProducts()
    }
    
    private func fetchProducts() {
        fruitSection = Products.allProducts.filter { $0.type == "Fruit" }
        vegetableSection = Products.allProducts.filter { $0.type == "Vegetable"}
    }
    
    //MARK: - Cart Management
    func addToCart(product: Products) {
        var canAddToCart = false
        
        if let index = fruitSection.firstIndex(where: { $0.id == product.id }) {
            if fruitSection[index].quantity > 0 {
                fruitSection[index].quantity -= 1
                canAddToCart = true
            }
        } else if let index = vegetableSection.firstIndex(where: { $0.id == product.id }) {
            if vegetableSection[index].quantity > 0 {
                vegetableSection[index].quantity -= 1
                canAddToCart = true
            }
        }
        
        if canAddToCart {
            if let index = cartItems.firstIndex(where: { $0.id == product.id }) {
                cartItems[index].quantity += 1
            } else {
                var newProduct = product
                newProduct.quantity = 1
                cartItems.append(newProduct)
            }
        }
    }
    
    func removeFromCart(product: Products) {
        if let index = cartItems.firstIndex(where: { $0.id == product.id }) {
            if cartItems[index].quantity > 1 {
                cartItems[index].quantity -= 1
                
                if let index = fruitSection.firstIndex(where: { $0.id == product.id }) {
                    fruitSection[index].quantity += 1
                } else if let index = vegetableSection.firstIndex(where: { $0.id == product.id }) {
                    vegetableSection[index].quantity += 1
                }
            } else {
                cartItems.remove(at: index)
                
                if let index = fruitSection.firstIndex(where: { $0.id == product.id }) {
                    fruitSection[index].quantity += 1
                } else if let index = vegetableSection.firstIndex(where: { $0.id == product.id }) {
                    vegetableSection[index].quantity += 1
                }
            }
        }
    }
    
    func removeAll() {
        cartItems.forEach { product in
            deleteFromCart(product: product)
        }
    }
    
    func deleteFromCart(product: Products) {
        if let index = cartItems.firstIndex(where: { $0.id == product.id }) {
            let originalQuantity: Int
            
            if let fruitIndex = fruitSection.firstIndex(where: { $0.id == product.id }) {
                originalQuantity = Products.allProducts.first(where: { $0.id == product.id })?.quantity ?? 0
                fruitSection[fruitIndex].quantity = originalQuantity
            } else if let vegetableIndex = vegetableSection.firstIndex(where: { $0.id == product.id }) {
                originalQuantity = Products.allProducts.first(where: { $0.id == product.id })?.quantity ?? 0
                vegetableSection[vegetableIndex].quantity = originalQuantity
            }
            
            cartItems.remove(at: index)
        }
    }
}
