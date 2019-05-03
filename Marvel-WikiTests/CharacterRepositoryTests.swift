import XCTest
@testable import Marvel_Wiki

class CharacterRepositoryTests: XCTestCase {

    typealias Character = Marvel_Wiki.Character
    
    var characterRepository = DependencyGraph.shared.getCharacterRepository()
    
    var observer: CharacterRepositoryObserverMock?
    
    override func setUp() {
    
        observer = CharacterRepositoryObserverMock()
        characterRepository.add(observer: observer!)
    }
    
    func testSearchSignal() {
        
       characterRepository.search(value: "")
        
        characterRepository.pubSearched(characters: [Character]())
        
        XCTAssertTrue(observer!.searched)        
    }
    
    func testFailSignal() {
        
        characterRepository.pubError(message: "")
        
        XCTAssertTrue(observer!.failed)
    }
    
    func testFetchSignal() {
        
        characterRepository.pubFetched(characters: [Character]())
        
        XCTAssertTrue(observer!.fetched)
    }
    
    func testRemoveObserver() {
        
        characterRepository.remove(observer: observer!)
        
        characterRepository.pubSearched(characters: [Character]())
        
        XCTAssertFalse(observer!.searched)
    }
}

class CharacterRepositoryObserverMock: CharacterRepositoryObserver {
    
    typealias Character = Marvel_Wiki.Character
    
    public var fetched = false
    
    public var fetchedSingleCharacter = false
    
    public var failed = false
    
    public var searched = false
    
    init() {}
    
    func fetched(_ character: Character) {
    
        fetchedSingleCharacter = true
    }
    
    func fetched(_ characters: [Character]) {
        
        fetched = true
    }
    
    func failedWith(message: String) {
        
        failed = true
    }
    
    func search(_ characters: [Character]) {
        
        searched = true
    }
}
