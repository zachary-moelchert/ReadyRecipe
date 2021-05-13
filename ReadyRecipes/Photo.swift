//
//  Photo.swift
//  ReadyRecipes
//
//  Created by Zachary Moelchert on 5/9/21.
//

import UIKit
import Firebase

class Photo {
    var image: UIImage
    var photoUserID: String
    var photoURL: String
    var documentID: String

    var dictionary: [String: Any] {
        return ["photoUserID": photoUserID,  "photoURL": photoURL]
    }
    
    init(image: UIImage,  photoUserID: String, photoURL: String, documentID: String) {
        self.image = image
        self.photoUserID = photoUserID
        self.photoURL = photoURL
        self.documentID = documentID
    }
    
    convenience init() {
        let photoUserID = Auth.auth().currentUser?.uid ?? ""
        let photoUserEmail = Auth.auth().currentUser?.email ?? ""
        self.init(image: UIImage(), photoUserID: photoUserID, photoURL: "", documentID: "")
    }
    
    convenience init(dictionary: [String: Any]) {
        // working with a dictionary where key is a string
        let photoUserID = dictionary["photoUserID"] as! String? ?? ""
        let photoURL = dictionary["photoURL"] as! String? ?? ""
        self.init(image: UIImage(), photoUserID: photoUserID, photoURL: photoURL, documentID: "")
    }
    
    func saveData(recipe: Recipe, completion: @escaping (Bool) -> ()) {
        let db = Firestore.firestore()
        let storage = Storage.storage()
        // convert photo.image to a Data type so that it can be saved in Firebase Storage
        guard let photoData = self.image.jpegData(compressionQuality: 0.5) else {
            print("ERROR: Could not convert photo.image to Data.")
            return
        }
        
        // create metadata so that we can see the images in the Firebase Storage Console
        let uploadMetaData = StorageMetadata()
        uploadMetaData.contentType = "image/jpeg"
        // create a filename if necessary
        if documentID == "" {
            documentID = UUID().uuidString
        }
        // create a storage refrence to upload this image file to the recipe's folder
        let storageRef = storage.reference().child(recipe.documentID).child(documentID)
        // create an upload task
        let uploadTask = storageRef.putData(photoData, metadata: uploadMetaData) { (metadata, error) in
            if let error = error {
                print("ERROR: upload for ref \(uploadMetaData) failed. \(error.localizedDescription)")
            }
        }
        
        uploadTask.observe(.success) { (snapshot) in
            print("Upload to Firebase Storage was successful!")
            storageRef.downloadURL { (url, error) in
                guard error == nil else {
                    print("ERROR: Couldn't create a download url")
                    return completion(false)
                }
                guard let url = url else {
                    print("ERROR: url was nil adn this should not have happened because we've already shown there was no error")
                    return completion(false)
                }
                self.photoURL = "\(url)"
                // Create the dictionary representing data we want to save
                let dataToSave: [String: Any] = self.dictionary
                let ref = db.collection("recipes").document(recipe.documentID).collection("photos").document(self.documentID)
                ref.setData(dataToSave) { (error) in
                    guard error == nil else {
                        print("ERROR updating document")
                        return completion(false)
                    }
                    print("Added document: \(self.documentID) to recipe: \(recipe.documentID)")
                    completion(true)
                }
            }
        }
        uploadTask.observe(.failure) { (snapshot) in
            if let error = snapshot.error {
                print("ERROR: Upload task for file \(self.documentID) failed, in recipe \(recipe.documentID), with error \(error.localizedDescription)")
            }
            completion(false)
        }
    }
    
    func loadImage(recipe: Recipe, completion: @escaping (Bool) -> ()) {
        guard recipe.documentID != "" else {
            print("ERROR: Did not pass a valid recipe into loadImage")
            return
        }
        let storage = Storage.storage()
        let storageRef = storage.reference().child(recipe.documentID).child(documentID)
        storageRef.getData(maxSize: 25*1024*1024) { (data, error) in
            if let error = error {
                print("ERROR: an error occurred while reading data from file ref: \(storageRef) error = \(error.localizedDescription)")
                return completion(false)
            } else {
                self.image = UIImage(data: data!) ?? UIImage()
                return completion(true)
            }
        }
    }
}
