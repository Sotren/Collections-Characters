//
//  SelectedCharacterViewController.swift
//  TestGit
//
//  Created by Станислав Москальцов  on 31.05.2022.
//

import UIKit
import Kingfisher

class SelectedCharacterViewController: UIViewController {
    
    let viewModel = ActorSelectedViewModel()
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
        setupBinders()
        viewModel.requestData()
    }
    
    func setupBinders() {
        viewModel.actor.bind { [self ] actor in
            if let actor = actor {
                self.nameCharacter.text = "Имя актера: " + actor.name
                let url = URL(string: "\(actor.img)")
                self.imageView.kf.setImage(with: url)
                self.category.text = "Категория: " + actor.category
                self.portrayed.text = "Играет роль: " + actor.portrayed
                self.nickName.text = "Прозвище: " + actor.nickname
                self.status.text = "Статус: " + actor.status
                self.birthday.text = "Дата рождения: " + actor.birthday
            }
        }
//
//    private func setActorData (actorData: Character) {
//        nameCharacter.text = "Имя актера: " + actorData.name
//        let url = URL(string: "\(actorData.img)")
//        imageView.kf.setImage(with: url)
//        category.text = "Категория: " + actorData.category
//        portrayed.text = "Играет роль: " + actorData.portrayed
//        nickName.text = "Прозвище: " + actorData.nickname
//        status.text = "Статус: " + actorData.status
//        birthday.text = "Дата рождения: " + actorData.birthday
//    }
}
}
