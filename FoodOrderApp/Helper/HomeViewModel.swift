//
//  HomeViewModel.swift
//  FoodOrderApp
//
//  Created by Aynur on 09.01.26.
//


class HomeViewModel {
    private let manager = DataManager()
    
    var foods = [Food]()
    var categories = [Category]()
    var selectedCategoryId: Int?

    var onUpdate: (() -> Void)?

    func fetchData() {
        manager.completion = { [weak self] model, error in
            if error == nil {
                self?.categories = model?.categories ?? [] //self?.manager.categories ?? []
                self?.foods = model?.foods ?? []
                self?.onUpdate?()
            }
        }
        manager.getHomeData()
    }
    func filteredFoods(searchText: String = "") -> [Food] {
        var result = foods
        if let id = selectedCategoryId, id != 0 {
            result = result.filter { $0.categoryId == id }
        }
        if !searchText.isEmpty {
            result = result.filter { $0.name?.lowercased().contains(searchText.lowercased()) ?? false }
        }
        return result
    }

}
