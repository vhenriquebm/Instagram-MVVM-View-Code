//
//  ImageUploader.swift
//  Insta
//
//  Created by Vitor Henrique Barreiro Marinho on 22/08/22.
//

import FirebaseStorage

struct ImageUploader {
    
    static func uploadImage(image: UIImage, completion: @escaping(String) -> ()) {
        
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {return}
        
        let fileName = NSUUID().uuidString
        let reference = Storage.storage().reference(withPath: "/profile_images/\(fileName)")
        
        reference.putData(imageData, metadata: nil) { metadata, error in
            
            if let error = error {
                print ("DEBUG: Failed to upload image \(String(describing: error.localizedDescription))")
                return
            }
            
            reference.downloadURL { url, error in
                guard let imageUrl = url?.absoluteString else {return}
                
                completion(imageUrl)
            }
            
        }
        
     
    }
}
