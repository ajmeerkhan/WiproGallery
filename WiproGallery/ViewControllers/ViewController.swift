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
        
        navigationItem.title = "Loading..."
        
        let button = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshData))
        navigationItem.rightBarButtonItem = button
        
        self.view.backgroundColor = UIColor(red: 239.0/255.0, green: 240.0/255.0, blue: 241.0/255.0, alpha: 1.0)

        createTheGalleryCollectionView()
    }
    

    @objc func refreshData () {
        guard let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json") else {
            return
        }
        NetworkApi().fetchGallery(url: url) { (response, error) in
            if error == nil {
                guard let data = response else{
                    self.showErrorMessages(errorMessage: "No Data Found!")
                    return
                }
                
                guard let str = String(bytes: data, encoding: .ascii) else {
                    self.showErrorMessages(errorMessage: "Encoding Error!")
                    return
                }
                
                let utfData = Data(str.utf8)
                do {
                    let gallery = try JSONDecoder().decode(Gallery.self, from: utfData)
                    DispatchQueue.main.async {
                        self.navigationItem.title = gallery.title
                        self.galleryContent = gallery.rows
                        self.collectionView.reloadData()
                    }
                }catch{
                    self.showErrorMessages(errorMessage: error.localizedDescription)
                }
            }else{
                self.showErrorMessages(errorMessage: error?.localizedDescription ?? "Unexpected error!")
            }
        }
    }
    
    func showErrorMessages (errorMessage:String) {
        DispatchQueue.main.async {
            self.navigationItem.title = "Error Loading..."
            let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension ViewController {
    func createTheGalleryCollectionView () {
        
        //Initialize CollectionView
        let flowLayout = UICollectionViewFlowLayout()
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
     
        refreshData()
    }
}

extension ViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galleryContent.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gallerycell", for: indexPath) as! GalleryCell
        cell.backgroundColor = .clear
        
        cell.dispalyTheGalleryUI(galleryRow: galleryContent[indexPath.row])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height :CGFloat = 180.0
        
        if let heading = galleryContent[indexPath.row].title {
            let headingHeight =  NSString(string: heading).boundingRect(with: CGSize(width: collectionView.frame.width - 30, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16.0)], context: nil)
            height += headingHeight.height
        }

        
        if let desc = galleryContent[indexPath.row].description {
            let descHeight =  NSString(string: desc).boundingRect(with: CGSize(width: collectionView.frame.width - 30, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14.0)], context: nil)
            height += descHeight.height
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            return CGSize(width: (collectionView.frame.width / 2) - 30, height: height )
        }else{
            return CGSize(width: collectionView.frame.width - 30, height: height )
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 10, left: 0, bottom: 10, right: 0)
    }
}

