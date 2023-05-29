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
        print("Hello world!")
    }
    
    
    private func setupCollectionView() {
        let layout = TwoColumnLayout.createTwoColumnLayout(in: view)
        
        collectionView = UICollectionView(frame: .zero,
                                           collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(AmbiCell.self, forCellWithReuseIdentifier: AmbiCell.id)
    }
}

extension MainVC: MainVCViewProtocol {
    
}

// MARK: - CollectionView

extension MainVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.ambiences?.all.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AmbiCell.id, for: indexPath) as! AmbiCell
        guard let ambience = presenter.ambiences?.all[indexPath.row] else {
            return cell
        }
        
        cell.configure(ambience: ambience)
        
        return cell
    }
    
}

extension MainVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 
    }
}
