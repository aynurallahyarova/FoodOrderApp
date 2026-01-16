//
//  HomeController.swift
//  FoodOrderApp
//
//  Created by Aynur on 07.01.26.
//

import UIKit


//header silirsen
//category collectionview elave edirsen - ekranin en ustune


class HomeController: UIViewController {
    
    @IBOutlet weak var foodCollection: UICollectionView!
    
    @IBOutlet weak var categoryCollection: UICollectionView!
    
    let viewModel = HomeViewModel()
    var selectedIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
        configureCollections()
    }
    func configureCollections() {
        categoryCollection.delegate = self
        categoryCollection.dataSource = self
        categoryCollection.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
        foodCollection.delegate = self
        foodCollection.dataSource = self
        foodCollection.register(UINib(nibName: "PopularCell", bundle: nil),forCellWithReuseIdentifier: "PopularCell")
    }
    func fetch() {
        viewModel.fetchData()
        viewModel.onUpdate = { [weak self] in
            self?.categoryCollection.reloadData()
            self?.foodCollection.reloadData()
        }
    }
}
extension HomeController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {

        if collectionView == categoryCollection {
            return viewModel.categories.count
        } else {
            return viewModel.filteredFoods().count
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == categoryCollection {

            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "CategoryCell",
                for: indexPath
            ) as! CategoryCell

            cell.configure(
                model: viewModel.categories[indexPath.item],
                selected: indexPath.item == selectedIndex
            )
            return cell

        } else {

            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "PopularCell",
                for: indexPath
            ) as! PopularCell

            cell.configure(
                model: viewModel.filteredFoods()[indexPath.item]
            )
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {

        if collectionView == categoryCollection {
            selectedIndex = indexPath.item
            viewModel.selectedCategoryId =
                viewModel.categories[indexPath.item].id
            categoryCollection.reloadData()
            foodCollection.reloadData()
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        if collectionView == categoryCollection {
            return CGSize(width: 120, height: 40) // 100 → 120
        } else {
            return CGSize(width: (collectionView.frame.width - 24) / 2,
                          height: 240)
        }
    }

}
