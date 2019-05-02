import Foundation
import RxSwift

class CharacterListViewModel {
    
    var newElements = PublishSubject<Bool>()
    
    var specificElement = PublishSubject<CharacterDetailViewModel>()
    
    private var characters = [Character]() {
        didSet {
            newElements.onNext(true)
        }
    }

    private var searchedCharacters = [Character]() {
        didSet {
            newElements.onNext(true)
        }
    }
    
    private var repository: CharacterRepository

    init(characterRepository: CharacterRepository) {
        
        self.repository = characterRepository
        self.characters.append(contentsOf: characterRepository.getCachedCharacters())
        repository.add(observer: self)
    }
    
    var numberOfCells: Int {
        return characters.count
    }
    
    func searchCharacterWith(value: String?) {
        
        guard let _query = value else {
            resetCachedCharacters()
            return
        }
        _query.isEmpty ? resetCachedCharacters() : repository.search(value: _query)
    }
    
    func getCharacterDetailsOn(position: Int) {
    
        
        repository.get(id: characters[position].id)
    }
    
    func resetCachedCharacters() {
        characters = repository.getCachedCharacters()
    }
    
    func fetchCharacters() {
        repository.fetchNewCharacters()
    }
    
    func getCharacterCellViewModel(for row: Int) -> CharacterCellViewModel? {
        
        return CharacterCellViewModel(character: characters[row])
    }
}
extension CharacterListViewModel: CharacterRepositoryObserver {
    
    func fetched(_ character: Character) {
        self.specificElement.onNext(CharacterDetailViewModel(character: character))
    }
    
    func fetched(_ characters: [Character]) {
        self.characters.append(contentsOf: characters)
    }
    
    func search(_ characters: [Character]) {
        self.characters = characters
    }
    
    func failedWith(message: String) {
        print(message)
    }
}