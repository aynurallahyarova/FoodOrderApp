//
//  BasketItem+CoreDataProperties.swift
//  FoodOrderApp
//
//  Created by Aynur on 17.01.26.
//
//

import Foundation
import CoreData


extension BasketItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BasketItem> {
        return NSFetchRequest<BasketItem>(entityName: "BasketItem")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var price: Double
    @NSManaged public var image: String?
    @NSManaged public var quantity: Int64

}

extension BasketItem : Identifiable {

}
