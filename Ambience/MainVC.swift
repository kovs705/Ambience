//
//  MainVC.swift
//  Ambience
//
//  Created by Kovs on 28.05.2023.
//

import UIKit
import SwiftUI
import WhatsNewPack

class MainVC: UIViewController {
    
    var presenter: MainVCPresenter!
    
    private var collectionView: UICollectionView!
    private var descriptionLabel = UILabel()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        
        setupCollectionView()
        configureUI()
        placeCV()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            showWhatsNew()
        }
    }
    
    // MARK: - UI func
    
    func configureUI() {
        view.addSubviews(collectionView)
        
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createTwoColumnLayout(in: view))

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(AmbiCell.self, forCellWithReuseIdentifier: AmbiCell.id)
        
        collectionView.backgroundColor = .systemBackground
        collectionView.alwaysBounceVertical = true
        collectionView.isScrollEnabled = true
    }
    
    private func placeCV() {
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(view)
        }
    }
    
    private func showWhatsNew() {
        let whatsNewViewController = UIHostingController(rootView: WhatsNewView())
        whatsNewViewController.modalPresentationStyle = .pageSheet
        present(whatsNewViewController, animated: true)
    }
}

// MARK: - Protocol
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
        cell.isHighlighted = false
        
        return cell
    }
    
}

extension MainVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let ambience = AmbienceManager().all[indexPath.row]
        let coordinator = Builder()
        let vc = coordinator.getDetailModule(ambience: ambience)
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
