//
//  DataManaager.swift
//  FoodOrderApp
//
//  Created by Aynur on 09.01.26.
//

import Foundation

class DataManager {
//    var categories: [Category] = []
//    var foods: [Food] = []
    
    var completion: ((HomeModel?, String?)-> Void)?
    func getHomeData() {
        guard let url = Bundle.main.url(forResource: "Categories", withExtension: "json") else {
            completion?(nil, "Data file not found")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let model = try JSONDecoder().decode(HomeModel.self, from: data)
//            categories = model.categories ?? []
//            foods = model.foods ?? []
            completion?(model, nil)
        } catch {
            completion?(nil, error.localizedDescription)
            
        }
    }
}
