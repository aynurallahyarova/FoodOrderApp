//
//  HomeController.swift
//  FoodOrderApp
//
//  Created by Aynur on 07.01.26.
//

import UIKit

class HomeController: UIViewController {
    @IBOutlet weak var collection: UICollectionView!
    let viewModel = HomeViewModel()
    var categories: [Category] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
        configureUI()
    }
    
    func configureUI() {
        collection.reloadData()
        
        collection.delegate = self
        collection.dataSource = self
        
        collection.register(
            UINib(nibName: "PopularCell", bundle: nil),
            forCellWithReuseIdentifier: "PopularCell"
        )
        
        collection.register(
            UINib(nibName: "CategoryCell", bundle: nil),
            forCellWithReuseIdentifier: "CategoryCell"
        )
        collection.register(
            UINib(nibName: "HomeHeader", bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "HomeHeader"
        )
    }
    
    
    private func fetch() {
        viewModel.onUpdate = { [weak self] in
            self?.collection.reloadData()
        }
        viewModel.fetchData()
    }
}

extension HomeController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int { 2 }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.categories.count
        } else {
            return viewModel.filteredFoods().count
            
        }
        
    }
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: "HomeHeader",
            for: indexPath
        ) as! HomeHeader
        
        header.categoriesLabel.text = "Categories"
        header.popularLabel.text = "Popular Now"
        
        header.categories = viewModel.categories
        header.collection.reloadData()
        
        header.onSelect = { [weak self] id in
            self?.viewModel.selectedCategoryId = id
            self?.collection.reloadSections(IndexSet(integer: 1))
        }
        
        return header
    }
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            let category = viewModel.categories[indexPath.item]
            viewModel.selectedCategoryId = category.id
            collection.reloadSections(IndexSet(integer: 1))
        }


        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "CategoryCell",
                for: indexPath) as! CategoryCell
            
            let model = viewModel.categories[indexPath.item]
            let selected = model.id == viewModel.selectedCategoryId
            cell.configure(model: model, selected: selected)
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "PopularCell",
                for: indexPath) as! PopularCell
            
            cell.configure(model: viewModel.filteredFoods()[indexPath.item])
            return cell
        }
    }

    
    //extension HomeController {
    //
    //    func collectionView(_ collectionView: UICollectionView,
    //                        viewForSupplementaryElementOfKind kind: String,
    //                        at indexPath: IndexPath) -> UICollectionReusableView {
    //        let header = collectionView.dequeueReusableSupplementaryView(
    //            ofKind: kind,
    //            withReuseIdentifier: "HomeHeader",
    //            for: indexPath) as! HomeHeader
    //
    //        header.categories = viewModel.categories
    //        header.onSelect = { [weak self] id in
    //            self?.viewModel.selectedCategoryId = id
    //            self?.collection.reloadData()
    //        }
    //
    //        return header
    //    }
    //}
    
}
extension HomeController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {

        if section == 0 {
            return CGSize(width: collectionView.frame.width, height: 300)
        } else {
            return .zero
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            return CGSize(width: 100, height: 40)
        } else {
            let width = (collectionView.frame.width - 24) / 2
            return CGSize(width: width, height: 220)
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        scrollDirectionForSectionAt section: Int) -> UICollectionView.ScrollDirection {
        return section == 0 ? .horizontal : .vertical
    }
}

