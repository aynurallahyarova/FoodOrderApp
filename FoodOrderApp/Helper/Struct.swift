//
//  Struct.swift
//  FoodOrderApp
//
//  Created by Aynur on 09.01.26.
//

import Foundation

struct Category: Codable {
    let id: Int?
    let name: String?
    let image: String?
}
struct Food: Codable {
    let id: Int?
    let name: String?
    let price: Double?
    let image: String?
    let categoryId: Int?
    let ingredients: String?
}
struct HomeModel: Codable {
    let categories: [Category]?
    let foods: [Food]?
}
