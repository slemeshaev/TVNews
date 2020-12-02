//
//  NewsCell.swift
//  TVNews
//
//  Created by Станислав Лемешаев on 02.12.2020.
//

import UIKit

class NewsCell: UICollectionViewCell {
    //
    @IBOutlet weak var imageView: RemoteImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var unfocusedConstraint: NSLayoutConstraint!
    
    var focusedConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        focusedConstraint = textLabel.topAnchor.constraint(equalTo: imageView.focusedFrameGuide.bottomAnchor, constant: 15)
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        focusedConstraint.isActive = isFocused
        unfocusedConstraint.isActive = !isFocused
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)
        
        coordinator.addCoordinatedAnimations({
            self.layoutIfNeeded()
        })

    }
}
