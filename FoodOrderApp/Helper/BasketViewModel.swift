//
//  BasketViewModel.swift
//  FoodOrderApp
//
//  Created by Aynur on 17.01.26.
//

import Foundation
import CoreData
class BasketViewModel {
    private var items: [BasketItem] = []
    
    func fetchItems() {
        let request: NSFetchRequest<BasketItem> = BasketItem.fetchRequest()
        items = (try? CoreDataManager.shared.context.fetch(request)) ?? []
    }
    func itemCount() -> Int {
        return items.count
    }
    func item(at Index: Int) -> BasketItem {
        items[Index]
    }
    func totalPrice() -> Double {
        var total: Double = 0
        for item in items {
            total += item.price * Double(item.quantity)
        }
        return total
    }
    func add(name: String, price: Double, img: String) {
        let item = BasketItem(context: CoreDataManager.shared.context)
        item.id = Int64(items.count + 1)
        item.name = name
        item.price = price
        item.quantity = 1
        item.image = img
        CoreDataManager.shared.save()
        fetchItems()
    }
}
    
