//
//  ActorListViewModel.swift
//  TestGit
//
//  Created by Станислав Москальцов  on 17.08.2022.
//

import Foundation
import UIKit

protocol CharactersListViewModelDelegate {
    func tableView()
}

final class CharactersListViewModel {
    
    var filteredCharacters: [Character] = []
    var characters: [Character] = []
    var delegate: CharactersListViewModelDelegate?
    
    func requestData() {
        CharacterManager.shared.fetchData(from: Networking.urlString) { [weak self] character in
            if character.isEmpty {
                self?.filteredCharacters = CharacterManager().charactersLocal
                self?.characters = CharacterManager().charactersLocal
                self?.delegate?.tableView()
            } else {
                self?.filteredCharacters = character
                self?.characters = character
                self?.delegate?.tableView()
            }
        }
    }
    
    func search(searchText: String) {
        filteredCharacters = searchText.isEmpty ? characters : characters.filter {(item: Character) -> Bool in
            return item.name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
    }
}
