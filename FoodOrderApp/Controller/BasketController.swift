//
//  BasketController.swift
//  FoodOrderApp
//
//  Created by Aynur on 07.01.26.
//

import UIKit

class BasketController: UIViewController {

    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var collection: UICollectionView!
    let viewModel = BasketViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.dataSource = self
        collection.delegate = self
        collection.register(
            UINib(nibName: "PopularCell", bundle: nil),
            forCellWithReuseIdentifier: "PopularCell"
        )
        title = "Basket"


    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchItems()
        viewModel.fetchItems()
        upDateTotal()
        collection.reloadData()
    }
    private func upDateTotal() {
        totalLabel.text = "Total: \(viewModel.totalPrice)$"
    }
}
extension BasketController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.itemCount()
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "PopularCell",
                for: indexPath
            ) as! PopularCell

            let item = viewModel.item(at: indexPath.item)

            let food = Food(
                id: Int(item.id),
                name: item.name,
                price: item.price,
                image: item.image,
                categoryId: nil,
                ingredients: nil
            )

            cell.configure(model: food)

            cell.addButton.isHidden = true
            cell.delegate = nil
            return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 16, height: 200)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

