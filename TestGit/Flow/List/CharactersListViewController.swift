//
//  ListViewController.swift
//  TestGit
//
//  Created by Станислав Москальцов  on 06.05.2022.
//

import UIKit

class CharactersListViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.register(ListTableViewCell.nib, forCellReuseIdentifier: ListTableViewCell.identifier)
            self.tableView.reloadData()
        }
    }
    let viewModel = CharactersListViewModel()
    var searchIsNotActive: Bool {
        guard let text = searchBar.text else {return false}
        return  text.isEmpty
    }
    var auth = UserContext()
    
    func setUpEmptyLabel() {
        let emptyLabel = UILabel()
        emptyLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 30)
        emptyLabel.text = "Данных по актерам нет"
        emptyLabel.textAlignment = NSTextAlignment.center
        self.tableView.backgroundView = emptyLabel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.requestData()
        tableView.dataSource = self
        tableView.delegate = self
        viewModel.delegate = self
        searchBar.delegate = self
        setUpExit()
    }
    
    func setUpExit () {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeTapped))
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(searchText: searchText)
        tableView.reloadData()
    }
    
    @objc func closeTapped () {
        auth.isAuth = false
        navigationController?.popViewController(animated: true)
    }
    
    private func pushToSelectedActor (charId: Int) {
        let storyboard = UIStoryboard(name: "SelectedCharacter", bundle: nil)
        guard let selectedCharacter = storyboard.instantiateViewController(identifier: "SelectedCharacterId") as? SelectedCharacterViewController else {
            return
        }
        selectedCharacter.charId = charId
        navigationController?.pushViewController(selectedCharacter, animated: true)
    }
}
//MARK: - Extension  tableViewDelegate, DataSource
extension CharactersListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchIsNotActive {
            return viewModel.characters.count
        }
        if tableView.visibleCells.isEmpty {
            setUpEmptyLabel()
        }
        return viewModel.filteredCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  ListTableViewCell.identifier,for: indexPath) as! ListTableViewCell
        if searchIsNotActive {
            cell.setDataToTableView(character: viewModel.characters[indexPath.row] )
        }
        cell.setDataToTableView(character: viewModel.filteredCharacters[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushToSelectedActor(charId: viewModel.characters[indexPath.row].charId)
    }
}
//MARK: - listViewModelDelegate
extension CharactersListViewController: CharactersListViewModelDelegate {
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
//MARK: - SearchBarDelegate
extension CharactersListViewController: UISearchBarDelegate {
    
}
