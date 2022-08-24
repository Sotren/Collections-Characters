//
//  ActorSelectedViewModel.swift
//  TestGit
//
//  Created by Станислав Москальцов  on 17.08.2022.
//

import Foundation
import UIKit
 
class ActorSelectedViewModel {
    
    var char_id: Int!
    let actor:Observable<Character?> = Observable(nil)
    func requestData() {
        guard let id = char_id else { return }
        CharacterManager.shared.fetchData(from: Networking.urlString + String(id)) { actorData  in
            return  self.actor.value = actorData.first
        }
    }
//   private func test () -> Character {
//        CharacterManager.shared.fetchData(from: Networking.urlString + String(char_id)) { actorData in
//            let actor = actorData.first
//            return actor
//        }
//    }
}

