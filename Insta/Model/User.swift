//
//  User.swift
//  Insta
//
//  Created by Vitor Henrique Barreiro Marinho on 26/08/22.
//

import Foundation

struct User {
    let email: String
    let fullName: String
    let profileImageuRL: String
    let uid: String
    let userName: String
    
    init (dictionary: [String:Any]) {
        self.email = dictionary["email"] as? String ?? ""
        self.fullName = dictionary["fullName"] as? String ?? ""
        self.profileImageuRL = dictionary["profileImageuRL"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.userName = dictionary["userName"] as? String ?? ""
    }
}
