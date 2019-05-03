import XCTest
@testable import Marvel_Wiki

class CharacterBuilderTests: XCTestCase {

    var dtoCharacter: ModelCharacter?
    
    var builder = Marvel_Wiki.Character.builder()
    
    override func setUp() {
   
        dtoCharacter = ModelCharacter(_id: 10
            , name: "Name"
            , _description: "Description"
            , modified: nil
            , resourceURI: nil
            , urls: nil
            , thumbnail: nil
            , comics: nil
            , stories: nil
            , events: nil
            , series: nil)
        }
    
    func testBuildCharacterWithNilId() {
        
        dtoCharacter?._id = nil
        
        do {
            _ = try builder.with(character: dtoCharacter!).build()
            XCTFail("Builder should return BuilderError")
        }
        catch let error as BuilderError {
            
            XCTAssertEqual(error, BuilderError.fieldNotSet("Character.id"))
        }
        catch {
            XCTFail("Wrong Error thrown from CharacterBuilder")
        }
    }
    
    func testBuildCharacterWithNilName() {
        
        dtoCharacter?.name = nil
        
        do {
            _ = try builder.with(character: dtoCharacter!).build()
            XCTFail("Builder should return BuilderError")
        }
        catch let error as BuilderError {
            
            XCTAssertEqual(error, BuilderError.fieldNotSet("Character.name"))
        }
        catch {
            XCTFail("Wrong Error thrown from CharacterBuilder")
        }
    }
}
