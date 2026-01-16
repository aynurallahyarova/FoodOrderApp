//
//  CategoryCell.swift
//  FoodOrderApp
//
//  Created by Aynur on 07.01.26.
//

import UIKit

class CategoryCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }
    
    func configure(model: Category, selected: Bool) {
        nameLabel.text = model.name
        image.image = UIImage(named: model.image ?? "")
        backgroundColor = selected ? .systemRed : .systemGray5
        nameLabel.textColor = selected ? .white : .black
        layer.cornerRadius = 20
        layer.masksToBounds = true
    }
}
