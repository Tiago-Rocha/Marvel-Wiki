import Foundation

struct CharacterDetailViewModel {
    
    private let character: Character
    
    init(character: Character) {
        
        self.character = character
    }
    
    var name: String {
        
        return character.name
    }
    
    var description: String {
        
        return character.description ?? "No description available"
    }
    
    var imageURL: URL? {
        
        guard
            let _baseURL = character.imageURL,
            let _imageFormat = character.imageFormat
            else {
                return nil
        }
        
        return URL(string: _baseURL + "/portrait_amazing." + _imageFormat)
    }
    
}
