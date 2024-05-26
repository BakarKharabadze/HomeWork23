//
//  ProductView.swift
//  GroceryStoreApp
//
//  Created by Bakar Kharabadze on 5/26/24.
//

import SwiftUI

struct ProductView: View {
    
    @StateObject private var viewModel = ProductViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            headerView
            headerLine
            listView
            Spacer()
            cartView
        }
    }
    
    //MARK: - Header View
    var headerView: some View {
        ZStack {
            Image("image")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 150)
                .clipped()
            
            Rectangle()
                .foregroundColor(.black)
                .opacity(0.6)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("სუპერმარკეტი")
                    .font(.system(size: 24))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 55)
                
                Text("ჯანმრთელი ხილი და ბოსტნეული")
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            .padding()
        }
        .frame(height: 150)
        .cornerRadius(10)
    }
    
    //MARK: - Header Line
    var headerLine: some View {
        HStack {
            Spacer()
            
            Text("პროდუქცია")
                .font(.system(size: 20))
                .padding()
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            Spacer()
        }
        .padding()
        .cornerRadius(100)
        .background(.white)
    }
    
    //MARK: - List View
    var listView: some View {
        ScrollView {
            sectionView(sectionName: "ხილი", products: viewModel.fruitSection)
            sectionView(sectionName: "ბოსტნეული", products: viewModel.vegetableSection)
        }
        .background(Color(.systemGray6))
    }
    
    //MARK: - Section View
    func sectionView(sectionName: String, products: [Products]) -> some View {
        Section(
            header: Text(sectionName)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .padding(.vertical, 5)
                .padding(.leading, 5)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.systemGray6))
        ) {
            VStack(spacing: 0) {
                ForEach(products, id: \.id) { product in
                    HStack {
                        Text(product.image)
                            .font(.system(size: 50))
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text(product.name)
                                .font(.headline)
                                .fontWeight(.semibold)
                            
                            Text(String("\(product.price)₾"))
                                .font(.subheadline)
                                .fontWeight(.semibold)
                        }
                        
                        Spacer()
                        
                        HStack {
                            Button(action: {
                                viewModel.removeFromCart(product: product)
                            }, label: {
                                Image(systemName: "minus.circle.fill")
                                    .foregroundColor(.red)
                            })
                            
                            Text("\(product.quantity)")
                                .font(.headline)
                            
                            Button(action: {
                                viewModel.addToCart(product: product)
                            }, label: {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.green)
                            })
                        }
                        
                        Button(action: {
                            viewModel.deleteFromCart(product: product)
                        }, label: {
                            Image(systemName: "trash.fill")
                                .foregroundColor(.red)
                        })
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.vertical, 5)
                }
            }
            .padding(.horizontal, 10)
        }
    }
    
    //MARK: - Cart View
    var cartView: some View {
        Group {
            if !viewModel.cartItems.isEmpty {
                VStack {
                    HStack {
                        Text("კალათა")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Text("რაოდენობა: \(viewModel.totalQuantity)")
                            .font(.headline)
                    }
                    
                    HStack {
                        Text("გადასახდელი თანხა:")
                            .font(.headline)
                        
                        Spacer()
                        
                        Text(String(format: "%.2f₾", viewModel.totalPrice))
                            .font(.headline)
                    }
                    HStack {
                        Button(action: {
                            viewModel.removeAll()
                        }) {
                            Text("წაშლა")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.red)
                                .cornerRadius(10)
                        }
                        
                        Button(action: {
                            if let url = URL(string: "https://www.google.com") {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            Text("გადახდა")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.green)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding()
                .background(Color(.systemGray6))
            } else {
                EmptyView()
            }
        }
    }
}

#Preview {
    ProductView()
}
