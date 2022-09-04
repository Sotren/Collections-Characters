//
//  ActorListViewModel.swift
//  TestGit
//
//  Created by Станислав Москальцов  on 17.08.2022.
//

import Foundation
import UIKit


final class ListViewModel {
    
    var actors:Observable<[Character]?> = Observable(nil)
    var localData:Observable<[Character]?> = Observable(nil)
    
    func requestData(listView: UITableView) {
        CharacterManager.shared.fetchData(from: Networking.urlString) { [weak self] character in
            if character.isEmpty {
                self?.localData.value = CharacterManager().charactersLocal
            } else {
                self?.actors.value = character
            }
            listView.reloadData()
        }
    }
}
