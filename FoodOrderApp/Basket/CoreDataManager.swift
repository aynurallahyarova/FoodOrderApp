//
//  CoreDataManager.swift
//  FoodOrderApp
//
//  Created by Aynur on 17.01.26.
//

import UIKit
import CoreData
class CoreDataManager {

    static let shared = CoreDataManager()
    private init() {}

    let context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext

    func save() {
        do {
            try context.save()
        } catch {
            print("Save error:", error)
        }
    }
}
