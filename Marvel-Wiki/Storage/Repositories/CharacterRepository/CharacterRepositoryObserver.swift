import Foundation

public protocol CharacterRepositoryObserver: class {
    
    func fetched(_ characters: [Character])
    
    func fetched(_ character: Character)
    
    func failedWith(message: String)
    
    func search(_ characters: [Character])
}
