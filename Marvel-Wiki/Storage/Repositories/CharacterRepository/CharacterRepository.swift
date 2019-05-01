import Foundation

class CharacterRepository {
    
    private var characterList = [Character]()
    
    private var currentOffset: Int {
        
        return characterList.count
    }
    
    private var limit = 50
    
    func get(id: Int) -> Character? {
        
        return nil
    }
    
    func search(value: String) -> [Character]? {
        
        return nil
    }
    
    func fetchNewCharacters() -> [Character]? {
        
        return nil
    }
    
    func getCachedCharacters() -> [Character] {
        
        return characterList
    }
}
