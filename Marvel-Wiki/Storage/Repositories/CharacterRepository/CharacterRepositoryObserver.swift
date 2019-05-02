import Foundation

protocol CharacterRepositoryObserver: class {
    
    func fetched(_ characters: [Character])
    
    func failedWith(message: String)
    
    func search(_ characters: [Character])
}
