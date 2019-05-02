import Foundation

class DependencyGraph {
    
    var characterRepository: CharacterRepository?
    
    static let shared = DependencyGraph()
    
    func getCharacterListViewController() -> CharacterListViewController {
        
        return CharacterListViewController(viewModel: getCharacterListViewModel())
    }
    
    func getCharacterListViewModel() -> CharacterListViewModel {
        return CharacterListViewModel(characterRepository: getCharacterRepository())
    }
    
    func getCharacterRepository() -> CharacterRepository {
        
        guard let _ = characterRepository else {
            characterRepository = CharacterRepository(marvelAPI: getMarvelAPI())
            return characterRepository!
        }
        return CharacterRepository(marvelAPI: getMarvelAPI())
    }
    
    func getMarvelAPI() -> MarvelAPI {
        
        return MarvelAPI(config: getMarvelAPIClientConfig()
            , factory: AlamofireRequestBuilderFactory()
            , authentication: MarvelAuthentication())
    }
    
    func getMarvelAPIClientConfig() -> SwaggerClientAPI {
        
        return SwaggerClientAPI(basePath: "https://gateway.marvel.com", credential: nil)
    }
}
