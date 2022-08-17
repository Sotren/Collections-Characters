//
//  SelectedCharacterViewController.swift
//  TestGit
//
//  Created by Станислав Москальцов  on 31.05.2022.
//

import UIKit
import Kingfisher

class SelectedCharacterViewController: UIViewController {
    
    var char_id: Int!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameCharacter: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var portrayed: UILabel!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var birthday: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestData()
    }
    
    private func requestData() {
        guard let id = char_id else { return }
        CharacterManager.shared.fetchData(from: Networking.urlString + String(id)) { actorData  in
            guard let actor = actorData.first else { return }
            self.setActorData(actorData: actor)
        }
    }
    
    private func setActorData (actorData: Character) {
        nameCharacter.text = "Имя актера: " + actorData.name
        let url = URL(string: "\(actorData.img)")
        imageView.kf.setImage(with: url)
        category.text = "Категория: " + actorData.category
        portrayed.text = "Играет роль: " + actorData.portrayed
        nickName.text = "Прозвище: " + actorData.nickname
        status.text = "Статус: " + actorData.status
        birthday.text = "Дата рождения: " + actorData.birthday
    }
}
