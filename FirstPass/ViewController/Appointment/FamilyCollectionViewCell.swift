//
//  FamilyCollectionViewCell.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 23/09/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import UIKit

class FamilyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var width: NSLayoutConstraint!
    @IBOutlet weak var memberImage: CustomImageView!
    
    private let customImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addSubview(customImageView)
        customImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        customImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        customImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        customImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        customImageView.heightAnchor.constraint(equalToConstant: 140).isActive = true
    }
    var imageUrl: String? {
        didSet {
            if let imageUrl = imageUrl {
                customImageView.loadImageWithUrl(urlString: imageUrl)
            }
        }
    }

}
