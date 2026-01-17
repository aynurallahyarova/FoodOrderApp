//
//  HomeController.swift
//  FoodOrderApp
//
//  Created by Aynur on 07.01.26.
//

import UIKit


//header silirsen
//category collectionview elave edirsen - ekranin en ustune


class HomeController: UIViewController, PopularCellDelegate {

    @IBOutlet weak var searchTextField: UITextField!
    func didTapAdd(food: Food) {
        basketViewModel.fetchItems()
        basketViewModel.add(name: food.name ?? "", price: food.price ?? 0, img: food.image ?? "")
        print("🛒 Added to basket:", food.name ?? "")
    }
    
    @IBOutlet weak var foodCollection: UICollectionView!
    @IBOutlet weak var categoryCollection: UICollectionView!
    
    let viewModel = HomeViewModel()
    var selectedIndex = 0
    let basketViewModel = BasketViewModel()
    var filteredFoods: [Food] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
        configureCollections()
        filteredFoods = viewModel.filteredFoods()
        searchTextField.addTarget(self, action: #selector(searchTextChanged), for: .editingChanged)
        
    }
    @objc func searchTextChanged() {
//        guard let text = self.searchTextField.text else { return }
//        if text.isEmpty {
//            filteredFoods = viewModel.filteredFoods()
//        } else {
//            filteredFoods = viewModel.filteredFoods().filter { $0.name?.lowercased().contains(text.lowercased()) ?? false }
//        }
//        foodCollection.reloadData()
        let text = searchTextField.text ?? ""
        filteredFoods = viewModel.filteredFoods(searchText: text)
        foodCollection.reloadData()
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
            guard let self = self else { return }
            self.filteredFoods = self.viewModel.filteredFoods()
            self.categoryCollection.reloadData()
            self.foodCollection.reloadData()
        }
    }
}
extension HomeController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {

        if collectionView == categoryCollection {
            return viewModel.categories.count
        } else {
            return filteredFoods.count
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
            let foodsArray = filteredFoods
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "PopularCell",
                for: indexPath
            ) as! PopularCell
            let food = foodsArray[indexPath.item]
            cell.configure(model: food)
            cell.delegate = self
            cell.addButton.isHidden = false
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollection {
            selectedIndex = indexPath.item
            viewModel.selectedCategoryId = viewModel.categories[indexPath.item].id
            let searchText = searchTextField.text ?? ""
            filteredFoods = viewModel.filteredFoods(searchText: searchText)
            
            categoryCollection.reloadData()
            foodCollection.reloadData()
        }
    }


    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        if collectionView == categoryCollection {
            return CGSize(width: 120, height: 40) 
        } else {
            return CGSize(width: (collectionView.frame.width - 24) / 2,
                          height: 240)
        }
    }

}
