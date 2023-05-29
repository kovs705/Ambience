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
        
        setupCollectionView()
        
    }
    
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createTwoColumnLayout(in: view))
        view.addSubview(collectionView)

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(AmbiCell.self, forCellWithReuseIdentifier: AmbiCell.id)
        
        collectionView.backgroundColor = .systemBackground
        collectionView.alwaysBounceVertical = true
    }
    
//    private func placeCV() {
//        view.addSubview(collectionView)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//
//        collectionView.snp.makeConstraints { make in
//            make.leading.trailing.equalToSuperview()
//            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
//        }
//    }
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
