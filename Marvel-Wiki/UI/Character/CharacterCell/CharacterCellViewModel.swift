import Foundation

struct CharacterCellViewModel {
    
    private let character: Character
    
    init(character: Character) {
        
        self.character = character
    }
    
    var imageURL: URL? {
        
        guard
            let _baseURL = character.imageURL,
            let _imageFormat = character.imageFormat
            else {
                return nil
        }
        
        return URL(string: _baseURL + "/landscape_medium." + _imageFormat)
    }
    
    var characterName: String {
        
        return character.name
    }
}
