//
//  MainTabBarController.swift
//  Insta
//
//  Created by Vitor Henrique Barreiro Marinho on 18/08/22.
//

import UIKit
import FirebaseAuth

class MainTabBarController: UITabBarController {
    
    //MARK: - Properties
    
    private var user: User?{
        didSet{
            guard let user = user else {return}
            configureTabViewController(with: user)
        }
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserIsLoggedIn()
        fetchCurrentUser()
    }
    
    //MARK: - Private methods
    
    private func configureTabViewController (with user: User) {
        
        view.backgroundColor = .white
        
        tabBar.tintColor = .black
        let layout = UICollectionViewFlowLayout()
        
        let feed =  templateNavigationController(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: FeedViewController(collectionViewLayout: layout))
        
        let notifications = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"), rootViewController: NotificationsViewController())
        
        
        let profileController = ProfileViewController(user: user)
        let profile = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected"), rootViewController: profileController)
        
        let imageSelector = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"), rootViewController: ImageSelectorViewController())
        
        let search = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected"), rootViewController: SearchViewController())
        
        viewControllers = [feed, search, imageSelector, notifications, profile]
        
    }
    
    private func templateNavigationController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController {
        
        let navigation = UINavigationController(rootViewController: rootViewController)
        navigation.tabBarItem.image = unselectedImage
        navigation.tabBarItem.selectedImage = selectedImage
        navigation.navigationBar.tintColor = .black
        return navigation
    }
    
    //MARK: - API
    
    private func checkIfUserIsLoggedIn() {
        
        let authentication = Auth.auth()
        
        DispatchQueue.main.async {
            if authentication.currentUser == nil {
                let controller = LoginViewController()
                controller.delegate = self
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
            }
        }
    }
    
    
    func fetchCurrentUser() {
       UserService.fetchUser { user in
           
           print ("o usuário atual é \(user)")
           self.user = user
       }
   }
}

extension MainTabBarController: AuthenticationDelegate {
    
    func authenticationComplete() {
        fetchCurrentUser()
    }
    
}
