//
//  ViewController.swift
//  WiproGallery
//
//  Created by Ajmeer khan on 31/05/19.
//  Copyright © 2019 Wirpo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var collectionView :UICollectionView!
    
    var galleryContent :[Row] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        createTheViewController()
        
        navigationController?.title = "Loading..."

        self.view.backgroundColor = UIColor(red: 239.0/255.0, green: 240.0/255.0, blue: 241.0/255.0, alpha: 1.0)
        GalleryApi().fetchGallery { gallery,error,status  in
//            print("Gallery \(gallery)")
            DispatchQueue.main.async {
                if let content = gallery, status {
                    self.navigationController?.title = content.title
                    self.galleryContent = content.rows
                    self.collectionView.reloadData()
                    print("Reload Done")
                }
            }
        }
    }
}

extension ViewController {
    func createTheViewController () {
        
        //Initialize CollectionView
        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.estimatedItemSize = CGSize(width: view.frame.width, height: 1.0)
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        self.view.addSubview(collectionView)
        
        collectionView.register(GalleryCell.self, forCellWithReuseIdentifier: "gallerycell")

        
        //Position of ContainerView
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        
    }
}

extension ViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("TOtal Rows : \(galleryContent.count)")
        return galleryContent.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gallerycell", for: indexPath) as! GalleryCell
        cell.backgroundColor = .clear
        
        cell.dispalyTheGalleryUi(galleryRow: galleryContent[indexPath.row])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height :CGFloat = 30.0
        
        if let heading = galleryContent[indexPath.row].rowTitle {
            let headingHeight =  NSString(string: heading).boundingRect(with: CGSize(width: collectionView.frame.width - 30, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16.0)], context: nil)
            height += headingHeight.height
        }

        
        if let desc = galleryContent[indexPath.row].description {
            let descHeight =  NSString(string: desc).boundingRect(with: CGSize(width: collectionView.frame.width - 30, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14.0)], context: nil)
            height += descHeight.height
        }
        
        
        return CGSize(width: collectionView.frame.width - 30, height: height + 150.0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 10, left: 0, bottom: 10, right: 0)
    }

    

}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}


