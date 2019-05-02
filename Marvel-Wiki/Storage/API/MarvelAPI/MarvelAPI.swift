import Foundation

class MarvelAPI {
    
    private let config: SwaggerClientAPI
    
    private let factory: RequestBuilderFactory
    
    private let authParams: MarvelAuthentication
    
    public init(config: SwaggerClientAPI, factory: RequestBuilderFactory, authentication: MarvelAuthentication) {
        
        self.config = config
        self.factory = factory
        self.authParams = authentication
    }
    
    /**
     Fetches a single character by id.
     
     - parameter characterId: (path) A single character id.
     - parameter completion: completion handler to receive the data and the error objects
     */
    public func getCharacterIndividual(characterId: Int, completion: @escaping ((_ data: CharacterDataWrapper?,_ error: ErrorResponse?) -> Void)) {
        getCharacterIndividualWithRequestBuilder(characterId: characterId).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }
    
    /**
     - parameter characterId: (path) A single character id.
     
     - returns: RequestBuilder<CharacterDataWrapper>
     */
    public func getCharacterIndividualWithRequestBuilder(characterId: Int) -> RequestBuilder<CharacterDataWrapper> {
        var path = "/v1/public/characters/{characterId}"
        let characterIdPreEscape = "\(characterId)"
        let characterIdPostEscape = characterIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{characterId}", with: characterIdPostEscape, options: .literal, range: nil)
        
        let URLString = config.basePath + path
        let parameters: [String:Any]? = nil
        
        var url = URLComponents(string: URLString)
        
        url?.queryItems = []
        
        url?.queryItems?.append(contentsOf: authParams.urlQueryItems)
        
        let requestBuilder: RequestBuilder<CharacterDataWrapper>.Type = factory.getBuilder()
        
        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    
    /**
     Fetches lists of characters.
     
     - parameter name: (query) Return only characters matching the specified full character name (e.g. Spider-Man). (optional)
     - parameter nameStartsWith: (query) Return characters with names that begin with the specified string (e.g. Sp). (optional)
     - parameter modifiedSince: (query) Return only characters which have been modified since the specified date. (optional)
     - parameter comics: (query) Return only characters which appear in the specified comics (accepts a comma-separated list of ids). (optional)
     - parameter series: (query) Return only characters which appear the specified series (accepts a comma-separated list of ids). (optional)
     - parameter events: (query) Return only characters which appear in the specified events (accepts a comma-separated list of ids). (optional)
     - parameter stories: (query) Return only characters which appear the specified stories (accepts a comma-separated list of ids). (optional)
     - parameter orderBy: (query) Order the result set by a field or fields. Add a \&quot;-\&quot; to the value sort in descending order. Multiple values are given priority in the order in which they are passed. (optional)
     - parameter limit: (query) Limit the result set to the specified number of resources. (optional)
     - parameter offset: (query) Skip the specified number of resources in the result set. (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    public func getCreatorCollection(name: String? = nil, nameStartsWith: String? = nil, modifiedSince: Date? = nil, comics: [Int]? = nil, series: [Int]? = nil, events: [Int]? = nil, stories: [Int]? = nil, orderBy: [String]? = nil, limit: Int? = nil, offset: Int? = nil, completion: @escaping ((_ data: CharacterDataWrapper?,_ error: Error?) -> Void)) {
        getCreatorCollectionWithRequestBuilder(name: name, nameStartsWith: nameStartsWith, modifiedSince: modifiedSince, comics: comics, series: series, events: events, stories: stories, orderBy: orderBy, limit: limit, offset: offset).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }
    
    /**
     - parameter name: (query) Return only characters matching the specified full character name (e.g. Spider-Man). (optional)
     - parameter nameStartsWith: (query) Return characters with names that begin with the specified string (e.g. Sp). (optional)
     - parameter modifiedSince: (query) Return only characters which have been modified since the specified date. (optional)
     - parameter comics: (query) Return only characters which appear in the specified comics (accepts a comma-separated list of ids). (optional)
     - parameter series: (query) Return only characters which appear the specified series (accepts a comma-separated list of ids). (optional)
     - parameter events: (query) Return only characters which appear in the specified events (accepts a comma-separated list of ids). (optional)
     - parameter stories: (query) Return only characters which appear the specified stories (accepts a comma-separated list of ids). (optional)
     - parameter orderBy: (query) Order the result set by a field or fields. Add a \&quot;-\&quot; to the value sort in descending order. Multiple values are given priority in the order in which they are passed. (optional)
     - parameter limit: (query) Limit the result set to the specified number of resources. (optional)
     - parameter offset: (query) Skip the specified number of resources in the result set. (optional)
     
     - returns: RequestBuilder<CharacterDataWrapper>
     */
    public func getCreatorCollectionWithRequestBuilder(name: String? = nil, nameStartsWith: String? = nil, modifiedSince: Date? = nil, comics: [Int]? = nil, series: [Int]? = nil, events: [Int]? = nil, stories: [Int]? = nil, orderBy: [String]? = nil, limit: Int? = nil, offset: Int? = nil) -> RequestBuilder<CharacterDataWrapper> {
        let path = "/v1/public/characters"
        let URLString = config.basePath + path
        let parameters: [String:Any]? = nil
        
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems([
            "name": name,
            "nameStartsWith": nameStartsWith,
            "modifiedSince": modifiedSince?.encodeToJSON(),
            "comics": comics,
            "series": series,
            "events": events,
            "stories": stories,
            "orderBy": orderBy,
            "limit": limit?.encodeToJSON(),
            "offset": offset?.encodeToJSON()
            ])
        
        url?.queryItems?.append(contentsOf: authParams.urlQueryItems)
        
        let requestBuilder: RequestBuilder<CharacterDataWrapper>.Type = factory.getBuilder()
        
        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
}
