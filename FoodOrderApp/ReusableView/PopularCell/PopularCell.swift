//
//  PopularCell.swift
//  FoodOrderApp
//
//  Created by Aynur on 07.01.26.
//

import UIKit

class PopularCell: UICollectionViewCell {

    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var ingredients: UILabel!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
  
    }
    func configure(model: Food) {
            foodName.text = model.name
        ingredients.text = model.ingredients
            price.text = "\(model.price ?? 0) $"
            foodImage.image = UIImage(named: model.image ?? "")
            layer.cornerRadius = 20
        }

}
