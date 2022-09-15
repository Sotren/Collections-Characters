//
//  ActorSelectedViewModel.swift
//  TestGit
//
//  Created by Станислав Москальцов  on 17.08.2022.
//

import Foundation
import UIKit

class SelectedCharacterViewModel {
    
    let actor: Observable<Character?> = Observable(nil)
    
    func requestData(id: Int) {
        CharacterManager.shared.fetchData(from: Networking.urlString + String(id)) { actorData  in
            self.actor.value = actorData.first
        }
    }
}
