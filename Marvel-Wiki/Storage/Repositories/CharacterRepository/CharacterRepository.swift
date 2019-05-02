import Foundation

class CharacterRepository {
    
    private var observers = [CharacterRepositoryObserver]()
    
    private var characterList = [Character]()
    
    private var marvelAPI: MarvelAPI
    
    init(marvelAPI: MarvelAPI) {
        self.marvelAPI = marvelAPI
    }
    
    private var currentOffset: Int {
        
        return characterList.count
    }
    
    private var limit = 50
    
    func get(id: Int) -> Character? {
        
        return nil
    }
    
    func search(value: String) {
        
        var searchedCharacters = [Character]()
        
        marvelAPI.getCreatorCollection(name: nil, nameStartsWith: value, modifiedSince: nil, comics: nil, series: nil, events: nil, stories: nil, orderBy: nil, limit: nil, offset: nil) { data, error in
            
            guard let _dtoCharacters = data?.data?.results else {
                self.errorSignal(message: String(error?.localizedDescription ?? "Generic Error"))
                return
            }
            
            for modelCharacter in _dtoCharacters {
                do {
                    searchedCharacters.append(try Character.builder().with(character: modelCharacter).build())
                }
                catch let error {
                    //Log Error
                }
            }
            
            self.searched(characters: searchedCharacters)
        }
    }
    
    func fetchNewCharacters() {
        
        var fetchedCharacters = [Character]()
        marvelAPI.getCreatorCollection(name: nil, nameStartsWith: nil, modifiedSince: nil, comics: nil, series: nil, events: nil, stories: nil, orderBy: nil, limit: nil, offset: characterList.count) { data, error in
            
            guard let _dtoCharacters = data?.data?.results else {
                self.errorSignal(message: String(error?.localizedDescription ?? "Generic Error"))
                return
            }
            
            for modelCharacter in _dtoCharacters {
                do {
                    fetchedCharacters.append(try Character.builder().with(character: modelCharacter).build())
                }
                catch let error {
                    //Log Error
                }
            }
            self.characterList.append(contentsOf: fetchedCharacters)
            self.new(characters: fetchedCharacters)
        }
    }
    
    func getCachedCharacters() -> [Character] {
        
        return characterList
    }
    
    deinit {
        observers.removeAll()
    }
}
extension CharacterRepository {
    
    func add(observer: CharacterRepositoryObserver) {
        self.observers.append(observer)
    }
    
    func new(characters: [Character]) {
        
        for observer in observers {
            
            observer.fetched(characters)
        }
    }
    
    func errorSignal(message: String) {
        for observer in observers {
            
            observer.failedWith(message: message)
        }
    }
    
    func searched(characters: [Character]) {
        for observer in observers {
            
            observer.search(characters)
        }
    }
}
