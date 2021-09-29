//
//  FeedbackTableViewCell.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 23/09/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import UIKit

class FeedbackTableViewCell: UITableViewCell{
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var feedback: UILabel!
    var rating = Int()
    var delegate:GetUserRatingsDelegate?
    var questionIndexDelegate:GetRatingQuestionIndexDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionview.register(UINib(nibName: "FeedbackCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "FeedbackCollectionViewCell")

        collectionview.dataSource = self
        collectionview.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension FeedbackTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedbackCollectionViewCell", for: indexPath) as! FeedbackCollectionViewCell
        if indexPath.row < rating{
            cell.icon.image = UIImage(named: "feedbackStarRated")
        }else{
            cell.icon.image = UIImage(named: "feedbackStarUnRated")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.getUserRating(rating: indexPath.row + 1)
        rating = indexPath.row + 1
        DispatchQueue.main.async {
            self.collectionview.reloadData()
        }
        questionIndexDelegate?.getRatingIndex(rating: indexPath.row + 1, index: collectionview.tag)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let cellSize = CGSize(width: (collectionView.bounds.width - (3 * 10))/12, height: 120)
        return cellSize
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        let sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return sectionInset
    }
    
}

