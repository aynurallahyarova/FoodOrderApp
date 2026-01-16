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

    func filteredFoods() -> [Food] {
        guard let id = selectedCategoryId else { return foods }
        return foods.filter { $0.categoryId == id }
    }
}
