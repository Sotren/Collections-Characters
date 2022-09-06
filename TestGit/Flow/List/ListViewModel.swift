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

    func requestData(listView: UITableView) {
        CharacterManager.shared.fetchData(from: Networking.urlString) { [weak self] character in
            self?.actors.value = character
        }
        listView.reloadData()
    }
}
