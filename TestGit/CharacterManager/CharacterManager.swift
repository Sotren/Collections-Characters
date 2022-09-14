//
//  CharacterManager.swift
//  TestGit
//
//  Created by Станислав Москальцов  on 12.05.2022.
//

import Foundation

class CharacterManager {
    
    static var shared = CharacterManager()
    @Published var charactersLocal = [Character]()
    
    init() {
        readLocalJson()
    }
    
    func fetchData(from urlString: String, with completion: @escaping ([Character]) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { [self] data, respond , Error in
            guard let data = data else { return }
            do {
                JSONDecoder().keyDecodingStrategy = .convertFromSnakeCase
                let characters = try JSONDecoder().decode([Character].self, from: data)
                DispatchQueue.main.async {
                    completion(characters)
                }
            } catch let errorJson {
                print(errorJson)
                completion(charactersLocal)
            }
            guard let error = Error else { return }
            print(error.localizedDescription)
        }.resume()
    }
    
    
    func readLocalJson() {
        if let fileLocation = Bundle.main.url(forResource: "Breakingbadapi" , withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let dataFromJson = try jsonDecoder.decode([Character].self, from: data)
                self.charactersLocal = dataFromJson
            } catch {
                print(error)
            }
        }
    }
    
}
