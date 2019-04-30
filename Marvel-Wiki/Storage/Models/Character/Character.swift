import Foundation

class Character {
    var id: Int
    
    var name: String
    
    var description: String?
    
    var imageURL: String?
    
    var imageFormat: String?
    
    init(id: Int, name: String, _ description: String?, _ imageURL: String?, _ imageFormat: String?) {
        
        self.id = id
        self.name = name
        self.description = description
        self.imageURL = imageURL
        self.imageFormat = imageFormat
    }
    
    public static func builder() -> CharacterBuilder {
        
        return CharacterBuilder()
    }
}
