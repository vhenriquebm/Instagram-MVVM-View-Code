//
//  ProfileViewController.swift
//  Insta
//
//  Created by Vitor Henrique Barreiro Marinho on 18/08/22.
//

import UIKit

class ProfileViewController: UICollectionViewController {
    
    var user: User? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        configureCollectionView()
        fetchCurrentUser()
        navigationController?.navigationBar.tintColor = .black
    }
    
        //MARK: - Private methods
    
    private func configureCollectionView() {
        collectionView.backgroundColor = .white
        
        collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileHeader.reuseIdentifier)
        
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: ProfileCell.reuseIdentifier)
    }
    
    func fetchCurrentUser() {
       
       UserService.fetchUser { user in
           
           self.user = user
           
           self.navigationItem.title = self.user?.userName

       }
       
   }
}

//MARK: - UICollectionViewDataSource

extension ProfileViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
}

//MARK: - UICollectionViewDelegate

extension ProfileViewController {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCell.reuseIdentifier, for: indexPath) as? ProfileCell {
            
            cell.backgroundColor = .red
            return cell
            
            

        }
        
        return UICollectionViewCell()
    }

    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileHeader.reuseIdentifier, for: indexPath) as? ProfileHeader {
            
            if let user = user {
                header.viewModel = ProfileHeaderViewModel(user: user)
            }
            
            return header
        }
        
        return UICollectionReusableView()
    }
    
}

//MARK: - UICollectionViewDelegate


extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widht = (view.frame.width - 2) / 3
        
        return CGSize(width: widht, height: widht)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 240)
    }
}
