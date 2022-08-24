//
//  ProfileCell.swift
//  Insta
//
//  Created by Vitor Henrique Barreiro Marinho on 24/08/22.
//

import UIKit


class ProfileCell: UICollectionViewCell {
    
    static var reuseIdentifier: String = "ProfileCell"

    
    // MARK: - Properties
    
    private lazy var postImageView: UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "venom-7")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    
    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .lightGray
        addSubViews()
        postImageView.fillSuperview()
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func addSubViews() {
        addSubview(postImageView)

        
    }

    
    
    
}
