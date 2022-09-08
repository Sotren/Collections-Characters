//
//  ActorListViewModel.swift
//  TestGit
//
//  Created by Станислав Москальцов  on 17.08.2022.
//

import Foundation
import UIKit

final class ListViewModel {
    
    var filteredCharacters: [Character] = []
    var characters: [Character] = []
    
    func requestData() {
        CharacterManager.shared.fetchData(from: Networking.urlString) { [weak self] character in
            self?.filteredCharacters = character
            self?.characters = character
        }
    }
    
    func search (searchText: String) {
        let characters = filteredCharacters
        filteredCharacters = searchText.isEmpty ? characters : characters.filter {(item:Character) -> Bool in
            return item.name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
    }
}
