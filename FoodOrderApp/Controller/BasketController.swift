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

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collection.reloadData()
        viewModel.fetchItems()
        upDateTotal()
    }
    private func upDateTotal() {
        totalLabel.text = "Total: \(viewModel.totalPrice)$"
    }
}
extension BasketController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.itemCount()
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "BasketCell",
            for: indexPath
        ) as! BasketCell

        let item = viewModel.item(at: indexPath.item)

        return cell
    }
}
