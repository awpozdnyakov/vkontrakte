//
//  AllPhotoController.swift
//  Vkontrakte
//
//  Created by Andrey Pozdnyakov on 30.11.2022.
//

import UIKit
import SDWebImage

class AllPhotoController: UIViewController {

    let session = Session.shared
    let service = Service()
    
    var photos = [Photo]()
    
    @IBOutlet var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        service.getAllPhoto(token: session.token) {
            photos in
            self.photos = photos
            self.collectionView.reloadData()
        }

    }

}


extension AllPhotoController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCollectionCell
        
        let photo = self.photos[indexPath.row].sizez?.first?.url
        if let photo = photo{
            cell.friendsPhoto.sd_setImage(with: URL(string: photo))
        }
        
        return cell
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "ShowBigPhoto",
//           let selectedPhoto = collectionView.indexPathsForSelectedItems?.first,
//           let bigPhotoVC = segue.destination as? BigPhotoController {
//
//            bigPhotoVC.photos = photos
//            bigPhotoVC.selectedPhotoIndex = selectedPhoto.item
//        }
//    }
    
}

//extension AllPhotoController {
//
//    func getPhoto() {
//
//        var urlComponents = URLComponents()
//        urlComponents.scheme = "https"
//        urlComponents.host = "api.vk.com"
//        urlComponents.path = "/method/photos.getAll"
//        urlComponents.queryItems = [
//            URLQueryItem(name: "owner_id", value: String(Session.shared.userID)),
//            URLQueryItem(name: "access_token", value: Session.shared.token),
//            URLQueryItem(name: "v", value: "5.131")
//        ]
//
//        guard let url = urlComponents.url else { return }
//
//        let request = URLRequest(url: url)
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print(error)
//            }
//            guard let data = data else {
//                return
//            }
//            do {
//                let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//                print("=======================")
//                print(result)
//                print("=======================")
//            } catch {
//                print(error)
//            }
//        }.resume()
//    }
//}
