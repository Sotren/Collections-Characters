//
//  TableViewCell.swift
//  TestGit
//
//  Created by Станислав Москальцов  on 06.05.2022.
//

import UIKit
import Foundation
import Kingfisher

class CharacterListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView! {
        didSet {
            let radius = photoImageView.bounds.width / 2
            photoImageView.layer.cornerRadius = radius
            photoImageView.layer.masksToBounds = true
            photoImageView.layer.borderWidth = 2
            photoImageView.layer.borderColor = UIColor.blue.cgColor
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setDataToTableView(character: Character) {
        nameLabel.text = character.name
        let url = URL(string: "\(character.img)")
        photoImageView.kf.setImage(with: url)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
