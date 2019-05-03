import Foundation

class CharacterRepository {
    
    private var observers = NSHashTable<AnyObject>.weakObjects()
    
    private var characterList = [Character]()
    
    private var marvelAPI: MarvelAPI
    
    init(marvelAPI: MarvelAPI) {
        self.marvelAPI = marvelAPI
    }
    
    private var currentOffset: Int {
        
        return characterList.count
    }
    
    private var limit = 50
    
    func get(id: Int) {
        
        marvelAPI.getCharacterIndividual(characterId: id) { data, error in
            
            guard let _dtoCharacter = data?.data?.results?.first else {
                self.pubError(message: String(error?.localizedDescription ?? "Failed to load character"))
                return
            }
        
            guard let character = try? Character.builder().with(character: _dtoCharacter).build() else {
                self.pubError(message: "Builder error")
                return
            }
         
            self.pubFetched(character: character)
        }
    }
    
    func search(value: String) {
        
        var searchedCharacters = [Character]()
        
        marvelAPI.getCreatorCollection(name: nil, nameStartsWith: value, modifiedSince: nil, comics: nil, series: nil, events: nil, stories: nil, orderBy: nil, limit: nil, offset: nil) { data, error in
            
            guard let _dtoCharacters = data?.data?.results else {
                self.pubError(message: String(error?.localizedDescription ?? "Generic Error"))
                return
            }
            
            for modelCharacter in _dtoCharacters {
                do {
                    searchedCharacters.append(try Character.builder().with(character: modelCharacter).build())
                }
                catch let _ {
                    //Log Error
                }
            }
            
            self.pubSearched(characters: searchedCharacters)
        }
    }
    
    func fetchCharacters() {
        
        var fetchedCharacters = [Character]()
        marvelAPI.getCreatorCollection(name: nil, nameStartsWith: nil, modifiedSince: nil, comics: nil, series: nil, events: nil, stories: nil, orderBy: nil, limit: nil, offset: characterList.count) { data, error in
            
            guard let _dtoCharacters = data?.data?.results else {
                self.pubError(message: String(error?.localizedDescription ?? "Generic Error"))
                return
            }
            
            for modelCharacter in _dtoCharacters {
                do {
                    fetchedCharacters.append(try Character.builder().with(character: modelCharacter).build())
                }
                catch _ {
                    //Log Error
                }
            }
            self.characterList.append(contentsOf: fetchedCharacters)
            self.pubFetched(characters: fetchedCharacters)
        }
    }
    
    func getCachedCharacters() -> [Character] {
        
        return characterList
    }
    
    deinit {
        observers.removeAllObjects()
    }
}
extension CharacterRepository {
    
    func add(observer: CharacterRepositoryObserver) {
        
        observers.add(observer)
    }
    
    func remove(observer: CharacterRepositoryObserver) {
        
        observers.remove(observer)
    }
    
    func pubFetched(characters: [Character]) {
        
        for observer in observers.allObjects {
            (observer as? CharacterRepositoryObserver)?.fetched(characters)
        }
    }
    
    func pubError(message: String) {
        
        for observer in observers.allObjects {
            (observer as? CharacterRepositoryObserver)?.failedWith(message: message)
        }
    }
    
    func pubSearched(characters: [Character]) {
        
        for observer in observers.allObjects {
            (observer as? CharacterRepositoryObserver)?.search(characters)
        }
    }
    
    func pubFetched(character: Character) {
        
        for observer in observers.allObjects {
            (observer as? CharacterRepositoryObserver)?.fetched(character)
        }
    }
}
