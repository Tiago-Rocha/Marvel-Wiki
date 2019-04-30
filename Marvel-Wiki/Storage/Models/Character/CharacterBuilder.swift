import Foundation

class CharacterBuilder {

    var id: Int?
    
    var name: String?
    
    var description: String?
    
    var imageURL: String?
    
    var imageExt: String?
    
    func with(id: Int?) -> Self {
        
        self.id = id
        return self
    }
    
    func with(name: String?) -> Self {
        
        self.name = name
        return self
    }
    
    func with(description: String?) -> Self {
        
        self.description = description
        return self
    }
    
    func with(imageURL: String?) -> Self {
        
        self.imageURL = imageURL
        return self
    }
    
    func with(imageExt: String?) -> Self {
        
        self.imageExt = imageExt
        return self
    }
    
    func with(character: ModelCharacter) -> Self {
        
        _ = with(id: character._id)
            .with(name: character.name)
            .with(imageURL: character.thumbnail?.path)
            .with(description: character._description)
            .with(imageExt: character.thumbnail?._extension)
        
        return self
    }
    
    func build() throws  -> Character {
        
        guard let _id = id else {
            
            throw BuilderError.fieldNotSet("Character.id")
        }
        
        guard let _name = name else {
            throw BuilderError.fieldNotSet("Character.name")
        }
        
        return Character(id: _id, name: _name, description, imageURL, imageExt)
    }
}

public enum BuilderError: Error {
    case fieldNotSet(String)
}
