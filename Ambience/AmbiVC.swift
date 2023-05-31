//
//  AmbiVC.swift
//  Ambience
//
//  Created by Kovs on 31.05.2023.
//

import UIKit
import SnapKit

class AmbiVC: UIViewController {
    
    var presenter: AmbiPresenterProtocol!
    
    private var imageView = UIImageView()
    
    private var soundB = UIButton()
    private var shuffleB = UIButton()
    private var nameLabel = UILabel()
    
    private var showMore = UIButton() // more sounds on MixKit
    
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        imageView.backgroundColor = .black
        setAmbience(ambience: presenter.ambience)
        configureUI()
        
        placeImageView()
    }
    
    
    // MARK: - Other funcs
    func configureUI() {
        view.addSubviews(imageView)
        
        
    }
    
    func placeImageView() {
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view)
        }
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
    }
    
}


// MARK: - Protocol
extension AmbiVC: AmbiViewProtocol {
    
    func setAmbience(ambience: Ambience?) {
        guard let image = ambience?.image else { return }
        DispatchQueue.main.async {
            self.imageView.image = UIImage(named: image)
        }
    }
    
}
