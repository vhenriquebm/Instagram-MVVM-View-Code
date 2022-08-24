//
//  AuthService.swift
//  Insta
//
//  Created by Vitor Henrique Barreiro Marinho on 22/08/22.
//

import FirebaseAuth
import FirebaseFirestore

struct Authservice {
    
    static func logUserIn(with email: String, password: String, completion: AuthDataResultCallback?) {
        
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    static func registerUserWith (credentials: AuthCredentials, completion: @escaping (Error?) -> Void )  {
        
        ImageUploader.uploadImage(image: credentials.profileImage)
        { imageUrl in
            
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { result, error in
                
                if let error = error {
                    print ("DEBUG: Failed to register user\(error.localizedDescription)")
                    return
                }
                
                guard let uid = result?.user.uid else {return}
                
                let data: [String:Any] = [
                    "email": credentials.email,
                    "fullName": credentials.fullname,
                    "profileImageuRL": imageUrl,
                    "uid": uid,
                    "userName": credentials.username
                ]
                
                Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
            }
            
        }
    }
}
