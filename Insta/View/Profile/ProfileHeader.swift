//
//  ProfileHeader.swift
//  Insta
//
//  Created by Vitor Henrique Barreiro Marinho on 24/08/22.
//

import UIKit
import SDWebImage

class ProfileHeader: UICollectionReusableView {
    
    static let reuseIdentifier: String = "ProfileHeader"
    
    var viewModel:ProfileHeaderViewModel? {
        didSet{
            configure()
        }
    }
    
    //MARK: - Properties
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .lightGray
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private lazy var editProfileFollowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Profile", for: .normal)
        button.layer.cornerRadius = 3
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 0.5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var postsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.attributedText = attributedStatText(value: 5, label: "posts")
        return label
    }()
    
    private lazy var followersLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.attributedText = attributedStatText(value: 2, label: "followers")
        return label
    }()
    
    private lazy var followingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.attributedText = attributedStatText(value: 1, label: "following")
        return label
    }()
    
    private lazy var userInfromationStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [postsLabel,followersLabel,followingLabel])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var gridButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "grid"), for: .normal)
        return button
    }()
    
    private lazy var listButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "list"), for: .normal)
        return button
    }()
    
    private lazy var bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "ribbon"), for: .normal)
        return button
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [gridButton, listButton,bookmarkButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var topDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var bottomDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        addSubViews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods
    
    private func addSubViews() {
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(editProfileFollowButton)
        addSubview(postsLabel)
        addSubview(followersLabel)
        addSubview(followingLabel)
        addSubview(userInfromationStackView)
        addSubview(gridButton)
        addSubview(listButton)
        addSubview(bookmarkButton)
        addSubview(buttonsStackView)
        addSubview(topDivider)
        addSubview(bottomDivider)
    }
    
    private func configureUI() {
        self.backgroundColor = .white
    }
    
    private func configureConstraints() {
        configureProfileImageViewConstraints()
        configureNameLabelConstraints()
        configureEditButtonConstraints()
        configureUserInformationStackViewConstraints()
        configureButtonsStackViewConstraints()
        configureTopDividerConstraints()
        configureBottomDividerConstraints()
    }
    
    private func configureProfileImageViewConstraints() {
        
        profileImageView.anchor(top:topAnchor, left: leftAnchor, paddingTop: 16, paddingLeft: 12)
        
        profileImageView.setDimensions(height: 80, width: 80)
        
        profileImageView.layer.cornerRadius = 80 / 2
    }
    
    private func configureEditButtonConstraints() {
        editProfileFollowButton.anchor(top:nameLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 24, paddingRight: 24)
        
    }
    
    private func configureNameLabelConstraints() {
        nameLabel.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 12)
    }
    
    private func configureUserInformationStackViewConstraints() {
        
        userInfromationStackView.centerY(inView: profileImageView)
        
        userInfromationStackView.anchor(left:profileImageView.rightAnchor, right: rightAnchor, paddingLeft: 12, paddingRight: 12, height: 50)
    }
    
    private func configureButtonsStackViewConstraints() {
        buttonsStackView.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 50)
    }
    
    private func configureTopDividerConstraints() {
        topDivider.anchor(top: buttonsStackView.topAnchor, left:  leftAnchor, right: rightAnchor, height: 0.5 )
    }
    
    private func configureBottomDividerConstraints() {
        bottomDivider.anchor(top: buttonsStackView.bottomAnchor, left:  leftAnchor, right: rightAnchor, height: 0.5 )
        
    }
    
    
    private func attributedStatText(value: Int, label: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: "\(value)\n", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: label, attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        return attributedText
    }
    
    @objc private func editButtonTapped() {
    print ("It is working when the button was tapped")
    }
    
    private func configure() {
        guard let viewModel = viewModel else {return}
        nameLabel.text = viewModel.getUsername
        profileImageView.sd_setImage(with: viewModel.getProfileImageURL)


    }
}
