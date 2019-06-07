//
//  GalleryCell.swift
//  WiproGallery
//
//  Created by Ajmeer khan on 04/06/19.
//  Copyright © 2019 Wirpo. All rights reserved.
//

import UIKit

class GalleryCell: UICollectionViewCell {
    
    var galleryContentView = UIView(frame: .zero)
    var headerLabel = UILabel(frame: .zero)
    var imageView = UIImageView(frame: .zero)
    var descriptionLabel = UILabel(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        setUpView()
    }
    
    private func setUpView (){
        
        
        contentView.addSubview(galleryContentView)
        galleryContentView.layer.cornerRadius = 10.0
        galleryContentView.layer.masksToBounds = true
        galleryContentView.translatesAutoresizingMaskIntoConstraints = false
        galleryContentView.backgroundColor = .white
        
        galleryContentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        galleryContentView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        galleryContentView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        let gallertyBottonConst = galleryContentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        gallertyBottonConst.priority = UILayoutPriority(999)
        gallertyBottonConst.isActive = true

        galleryContentView.addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.backgroundColor = .clear
        headerLabel.font = .systemFont(ofSize: 16.0)
        headerLabel.numberOfLines = 0
        
        headerLabel.topAnchor.constraint(equalTo: galleryContentView.topAnchor, constant: 10.0).isActive = true
        headerLabel.leadingAnchor.constraint(equalTo: galleryContentView.leadingAnchor, constant: 10.0).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: galleryContentView.trailingAnchor, constant: -10.0).isActive = true
        
        galleryContentView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.backgroundColor = .clear
        descriptionLabel.font = .systemFont(ofSize: 14.0)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .darkGray
        
        descriptionLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 10.0).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: headerLabel.leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: headerLabel.trailingAnchor).isActive = true

        
        galleryContentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "photos.png")
        
        imageView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10.0).isActive = true
        imageView.leadingAnchor.constraint(equalTo: galleryContentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: galleryContentView.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: galleryContentView.bottomAnchor, constant: -10.0).isActive = true


    }
    
    func dispalyTheGalleryUI (galleryRow :Row) {
        
        headerLabel.text = galleryRow.title
        descriptionLabel.text = galleryRow.description
        if let imageRef = galleryRow.imageHref {
            if let imageUrl = URL(string: imageRef) {
                imageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "photos.png"), options: .continueInBackground) { (image, error, cacheType, url) in
                    if error == nil {
                        self.imageView.image = image
                    }
                }
            }
        }else{
            imageView.image = UIImage(named: "photos.png")
        }
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        layoutAttributes.bounds.size.height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        layoutIfNeeded()
        return layoutAttributes
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
