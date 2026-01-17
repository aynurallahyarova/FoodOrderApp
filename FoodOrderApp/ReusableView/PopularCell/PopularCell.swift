//
//  PopularCell.swift
//  FoodOrderApp
//
//  Created by Aynur on 07.01.26.
//

import UIKit
protocol PopularCellDelegate: AnyObject {
    func didTapAdd(food: Food)
}
class PopularCell: UICollectionViewCell {
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var ingredients: UILabel!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    weak var delegate: PopularCellDelegate?
    private var food: Food?
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 20
        foodImage.contentMode = .scaleAspectFit
        foodImage.clipsToBounds = true
    }
    func configure(model: Food) {
        self.food = model
        foodName.text = model.name
        ingredients.text = model.ingredients
        price.text = "\(model.price ?? 0) $"
        foodImage.image = UIImage(named: model.image ?? "")
        layer.cornerRadius = 20
    }
    @IBAction func addButtonTapped(_ sender: Any) {
        guard let food = food else { return }
        delegate?.didTapAdd(food: food)
        
    }
}
