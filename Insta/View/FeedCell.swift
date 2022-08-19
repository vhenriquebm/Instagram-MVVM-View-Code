//
//  FeedCell.swift
//  Insta
//
//  Created by Vitor Henrique Barreiro Marinho on 18/08/22.
//

import UIKit

class FeedCell: UICollectionViewCell {
    
    static let reuseIdentifier:String = "Cell"
    
    // MARK: - Properties
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.image = #imageLiteral(resourceName: "venom-7")
        return iv
    }()
    
    private lazy var userNameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Venom", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.addTarget(self, action: #selector(didTapUserName), for: .touchUpInside)
        return button
    }()
    
    private lazy var postImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.image = #imageLiteral(resourceName: "venom-7")
        return iv
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "like_unselected"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "comment"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "send2"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private lazy var likesLabel: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.text = "1 like"
        return label
        
    }()
    
    private lazy var captionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "a text only for test"
        return label
    }()
    
    private lazy var postTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "2 days ago"
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews:[ likeButton, commentButton, shareButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapUserName () {
        
        print ("it is working")
    }
    
    private func configureUI () {
        addSubview(profileImageView)
        addSubview(userNameButton)
        addSubview(postImageView)
        addSubview(stackView)
        addSubview(likesLabel)
        addSubview(captionLabel)
        addSubview(postTimeLabel)
        configureConstraints()
    }
    
    private func configureConstraints () {
        
        profileImageConstraints()
        
        userNameButtonConstraints()
        
        postImageViewConstraints()
        
        stackViewConstraints()
        
        likesLabelConstraints()
        
        captionLabelConstraints()
        
        postTimeLabelConstraints()
    }
    
    private func profileImageConstraints () {
        profileImageView.anchor(top: topAnchor, left: leftAnchor,   paddingTop: 12, paddingLeft: 12)
        profileImageView.setDimensions(height: 40, width: 40)
        profileImageView.layer.cornerRadius = 40 / 2
    }
    
    private func userNameButtonConstraints() {
        userNameButton.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 8)
    }
    
    private func postImageViewConstraints () {
        postImageView.anchor(top: profileImageView.bottomAnchor, left: leftAnchor,  right: rightAnchor, paddingTop: 8)
        postImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
    }
    
    private func stackViewConstraints() {
        stackView.anchor(top: postImageView.bottomAnchor, width:120, height: 50)
    }
    
    private func likesLabelConstraints() {
        likesLabel.anchor(top: likeButton.bottomAnchor, left: leftAnchor, paddingTop: -4, paddingLeft: 8)
    }
    
    private func captionLabelConstraints() {
        captionLabel.anchor(top: likesLabel.bottomAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 8)
    }
    
    private func postTimeLabelConstraints() {
        postTimeLabel.anchor(top: captionLabel.bottomAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 8)
    }
}
