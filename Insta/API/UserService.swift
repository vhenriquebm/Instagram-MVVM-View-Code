//
//  UserService.swift
//  Insta
//
//  Created by Vitor Henrique Barreiro Marinho on 26/08/22.
//

import Firebase

struct UserService {
    
    static func fetchUser(completion: @escaping (User) -> ()) {
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            
            guard let dictionary = snapshot?.data() else {return}
            
            let user = User(dictionary: dictionary)
            
            completion(user)
        }
        
    }
}
