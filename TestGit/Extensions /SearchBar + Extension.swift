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
        listViewModel.search(searchText: searchText)
        self.listTableView.reloadData()
    }
}
