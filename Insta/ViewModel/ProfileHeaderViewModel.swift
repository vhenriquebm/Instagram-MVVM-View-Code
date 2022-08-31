//
//  ProfileHeaderViewModel.swift
//  Insta
//
//  Created by Vitor Henrique Barreiro Marinho on 31/08/22.
//

import Foundation

struct ProfileHeaderViewModel {
    
    private var user: User?
    
    var getUsername: String? {
        return user?.userName
    }
    
    var getFullName: String? {
        return user?.fullName
    }
    
    var getProfileImageURL: URL? {
        return URL(string: user?.profileImageuRL ?? "")
    }
    
    init (user: User){
        self.user = user
    }
    
    
    
    
    
    
}
