import Foundation

class Character {
    
    var id: Int
    
    var name: String
    
    var description: String?
    
    var imageURL: String?
    
    var imageFormat: String?
    
    init(id: Int, name: String, _ description: String? = nil, _ imageURL: String? = nil, _ imageFormat: String? = nil) {
        
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

extension Character: Hashable {
    
    public var hashValue: Int {
        return id
    }
    
    static func == (lhs: Character, rhs: Character) -> Bool {
        return lhs.id == rhs.id &&
        lhs.name == lhs.name &&
        lhs.description == rhs.description &&
        lhs.imageFormat == rhs.imageFormat &&
        lhs.imageURL == rhs.imageURL
    }
}
