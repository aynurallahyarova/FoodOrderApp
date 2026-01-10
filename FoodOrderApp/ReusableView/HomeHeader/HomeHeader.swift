//
//  HomeHeader.swift
//  FoodOrderApp
//
//  Created by Aynur on 07.01.26.
//

import UIKit

class HomeHeader: UICollectionReusableView {
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var popularLabel: UILabel!
    @IBOutlet weak var collection: UICollectionView!
    var categories = [Category]()
    var selectedIndex = 0
    var onSelect: ((Int) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        collection.delegate = self
        collection.dataSource = self
        collection.register(
            UINib(nibName: "CategoryCell", bundle: nil),
            forCellWithReuseIdentifier: "CategoryCell"
        )

    }
    func configure() {
        collection.reloadData()
    }
}
extension HomeHeader: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "CategoryCell",
            for: indexPath) as! CategoryCell

        cell.configure(
            model: categories[indexPath.item],
            selected: indexPath.item == selectedIndex
        )
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        onSelect?(categories[indexPath.item].id ?? 0)
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 40)
    }
}
