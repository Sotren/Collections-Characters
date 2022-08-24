//
//  ActorListViewModel.swift
//  TestGit
//
//  Created by Станислав Москальцов  on 17.08.2022.
//

import Foundation
import UIKit


final class ActorListViewModel {
    
var localData = CharacterManager().charactersLocal
var characters: [Character] = []
var filteredCharacters: [Character] = []

    func requestData(listView: UITableView) {
    CharacterManager.shared.fetchData(from: Networking.urlString) { [weak self] character in
        self?.localData = character
        self?.characters = character
        self?.filteredCharacters = character
       listView.reloadData()
    }
}
}
