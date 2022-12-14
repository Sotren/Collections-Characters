//
//  ListViewController.swift
//  TestGit
//
//  Created by Станислав Москальцов  on 06.05.2022.
//

import UIKit

class ListViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var listTableView: UITableView! {
        didSet {
            self.listTableView.register(ListTableViewCell.nib, forCellReuseIdentifier: ListTableViewCell.identifier)
            self.listTableView.reloadData()
        }
    }
    var localData = CharacterManager().charactersLocal
    var characters: [Character] = []
    var filteredCharacters: [Character] = []
    var searchIsNotActive: Bool {
        guard let text = searchBar.text  else { return false}
        return  text.isEmpty
    }
    var auth = UserContext()
    func setUpEmptyLabel() {
        let emptyLabel = UILabel()
        emptyLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 30)
        emptyLabel.text = "Данных по актерам нет"
        emptyLabel.textAlignment = NSTextAlignment.center
        self.listTableView.backgroundView = emptyLabel
    }
    
    func requestData() {
        CharacterManager.shared.fetchData(from: Networking.urlString) { character in
            self.localData = character
            self.characters = character
            self.filteredCharacters = character
            self.listTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestData()
        listTableView.dataSource = self
        listTableView.delegate = self
        searchBar.delegate = self
        setUpExit()
    }
    
    func setUpExit () {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeTapped))
        }
    
    @objc func closeTapped () {
        auth.isAuth = false
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "AuthorizationViewControllerID") as? AuthorizationViewController else {
            return
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredCharacters = searchText.isEmpty ? characters : characters.filter  {(item:Character) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return item.name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        self.listTableView.reloadData()
    }
    
    private func pushToSelectedActor (char_id: Int) {
        let storyboard = UIStoryboard(name: "SelectedCharacter", bundle: nil)
        guard let selectedCharacter = storyboard.instantiateViewController(identifier: "SelectedCharacterId") as? SelectedCharacterViewController else {
            return
        }
        selectedCharacter.char_id = char_id
        navigationController?.pushViewController(selectedCharacter, animated: true)
    }
}
//MARK: - Extension  tableViewDelegate, DataSource
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchIsNotActive {
            return characters.count
        }
        if tableView.visibleCells.isEmpty {
            setUpEmptyLabel()
        }
        return filteredCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  ListTableViewCell.identifier,for: indexPath) as! ListTableViewCell
        if searchIsNotActive {
            cell.setDataToTableView(character: characters[indexPath.row])
        }
        cell.setDataToTableView(character: filteredCharacters[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushToSelectedActor(char_id: characters[indexPath.row].char_id)
    }
}
//MARK: - SearchBarDelegate
extension ListViewController: UISearchBarDelegate {
    
}
