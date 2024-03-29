//
//  ExerciseTableViewCell.swift
//  Gymondo
//
//  Created by Amir Daliri on 8.01.2024.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var exerciseImageView: UIImageView!
    @IBOutlet private weak var exerciseNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        containerView.layer.cornerRadius = 8
        containerView.layer.masksToBounds = true
    }
    
    func setup(exercise: Exercise) {
        exerciseNameLabel.text = exercise.name
        exerciseImageView.setImage(with: exercise.getMainImageUrlString())
    }
}
