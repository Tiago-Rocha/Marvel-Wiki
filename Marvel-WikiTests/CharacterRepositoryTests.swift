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
    
    //Test observer setup
    
    func testObserverSetup() {
        
        XCTAssertEqual(characterRepository.observers.count, 1)
    }
    
    func testSearchSignal() {
        
        characterRepository.notifySearch()
        
        XCTAssertTrue(observer!.searched)        
    }
    
    func testFailSignal() {
        
        characterRepository.notifyFail()
        
        XCTAssert(observer!.failed)
    }
    
    func testFetchSignal() {
        
        characterRepository.notifyFetch()
        
        XCTAssert(observer!.fetched)
    }
    

}
fileprivate extension CharacterRepository
{
    fileprivate func notifySearch() {
        for observer in observers {
            observer.search([Marvel_Wiki.Character]())
        }
    }
    
    fileprivate func notifyFail() {
        for observer in observers {
            observer.failedWith(message: "")
        }
    }
    
    fileprivate func notifyFetch() {
        for observer in observers {
            observer.fetched([Marvel_Wiki.Character]())
        }
    }
}
class CharacterRepositoryObserverMock: CharacterRepositoryObserver {
    
    public var fetched = false
    
    public var failed = false
    
    public var searched = false
    
    init() {}
    
    func fetched(_ characters: [Marvel_Wiki.Character]) {
        fetched = true
    }
    
    func failedWith(message: String) {
        failed = true
    }
    
    func search(_ characters: [Marvel_Wiki.Character]) {
        searched = true
    }
}
