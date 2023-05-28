//
//  MainVC.swift
//  Ambience
//
//  Created by Kovs on 28.05.2023.
//

import UIKit

class MainVC: UIViewController {
    
    var presenter: MainVCPresenter!
    
    private var collectionView: UICollectionView!
    private var descriptionLabel = UILabel()
    
    override func viewDidLoad() {
        
    }
    
    
    private func setupCollectionView() {
        let layout = TwoColumnLayout.createTwoColumnLayout(in: view)
        
        collectionView = UICollectionView(frame: .zero,
                                           collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        // collectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: "categories")
    }
}

extension MainVC: MainVCViewProtocol {
    
}

// MARK: - CollectionView

extension MainVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
}

extension MainVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        <#code#>
    }
}
