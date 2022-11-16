//
//  FamilyMemberTableViewCell.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 19/09/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import UIKit

class FamilyMemberTableViewCell: UITableViewCell {
    
    @IBOutlet var calenderImage: UIImageView!
    @IBOutlet var relationImage: UIImageView!
    @IBOutlet var deleteButton: UIButton!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var pic: CustomImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var relationLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var dobLabel: UILabel!
    var delegate:EditFamilyMemberDelegate?
    
    
    var editButtonPressed : (() -> ()) = {}
    var deleteButtonPressed : (() -> ()) = {}


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
//        addSubview(customImageView)
//        customImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
//        customImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
//        customImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        customImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
//        customImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        customImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
//
//        customImageView.centerXAnchor.constraint(equalTo: pic.centerXAnchor).isActive = true
//        customImageView.centerYAnchor.constraint(equalTo: pic.centerYAnchor).isActive = true
    }
    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: .default, reuseIdentifier: reuseIdentifier)
//        
//        addSubview(customImageView)
//        customImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        customImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        
//        customImageView.centerXAnchor.constraint(equalTo: pic.centerXAnchor).isActive = true
//        customImageView.centerYAnchor.constraint(equalTo: pic.centerYAnchor).isActive = true
//        
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
        //pic.createCircle()
        // Configure the view for the selected state
    }
    
//    private let customImageView: CustomImageView = {
//        let imageView = CustomImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.contentMode = .scaleAspectFill
//        imageView.layer.masksToBounds = true
//        return imageView
//    }()
    
    
    func updateData(data:FamilyMembersList){
        name.text = data.full_name ?? ""
        dobLabel.text = data.dob ?? ""
        relationLabel.text = data.relation ?? ""
    }
    
    @IBAction func editAction(_ sender: UIButton) {
        //delegate?.editFamilyMember(index: sender.tag)
        editButtonPressed()
    }
    
    @IBAction func delete_Clicked(_ sender: Any)
    {
       deleteButtonPressed()
    }
    var imageUrl: String? {
        didSet {
            if let imageUrl = imageUrl {
                pic.loadImageWithUrl(urlString: imageUrl)
            }
        }
    }
}
