//
//  ViewController.swift
//  WiproGallery
//
//  Created by Ajmeer khan on 31/05/19.
//  Copyright © 2019 Wirpo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var headerView :UIView!
    var headerLabel :UILabel!
    var containerView :UIView!
    var collectionView :UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .blue

    }
    
    override func viewDidLayoutSubviews() {
        createTheViewController()
    }
    
    


}

extension ViewController {
    func createTheViewController () {
        
        //Initialize HeaderView
        headerView = UIView()
        headerView.backgroundColor = .blue
        self.view.addSubview(headerView)
        
        //Position of HeaderView
        headerView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            headerView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.safeAreaInsets.top).isActive = true
        } else {
            // Fallback on earlier versions
            headerView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: topLayoutGuide.length).isActive = true
        }
        headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        
        //Initialize HeaderLabel
        headerLabel = UILabel()
        headerLabel.text = "Gallery"
        headerLabel.textColor = .white
        headerLabel.font = .boldSystemFont(ofSize: 16.0)
        headerView.addSubview(headerLabel)
        
        //Position of HeaderLabel
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        
        //Initialize ContainerView
        containerView = UIView()
        containerView.backgroundColor = .white
        self.view.addSubview(containerView)
        
        //Position of ContainerView
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        containerView.bottomAnchor .constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        //Initialize CollectionView
        let flowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
//        collectionView.delegate = self
//        collectionView.dataSource = self
        collectionView.backgroundColor = .green
        containerView.addSubview(collectionView)
        
        //Position of ContainerView
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        collectionView.bottomAnchor .constraint(equalTo: containerView.bottomAnchor).isActive = true
    }
}

