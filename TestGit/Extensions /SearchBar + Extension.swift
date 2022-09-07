//
//  SearchBar + Extension.swift
//  TestGit
//
//  Created by Станислав Москальцов  on 07.09.2022.
//

import Foundation
import UIKit

//MARK: - SearchBarDelegate
extension ListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredCharacters = searchText.isEmpty ? characters : characters.filter  {(item:Character) -> Bool in
            return item.name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        self.listTableView.reloadData()
    }
}
