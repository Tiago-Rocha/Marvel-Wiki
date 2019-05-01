import Foundation

struct CharacterListViewModel {
    
    private var characters = [Character]()

    private var repository: CharacterRepository

    init(characterRepository: CharacterRepository) {
        
        self.repository = characterRepository
        self.characters.append(contentsOf: characterRepository.getCachedCharacters())
    }
    
    var numberOfCells: Int {
        return 10
        return characters.count
    }
    
    func fetchCharacters() {
        repository.fetchNewCharacters()
    }
    
    func getCharacterCellViewModel(for row: Int) -> CharacterCellViewModel? {
        
        
        let character = Character(id: 10
            , name: "YAAA")
        return CharacterCellViewModel(character: character)
    }
}
