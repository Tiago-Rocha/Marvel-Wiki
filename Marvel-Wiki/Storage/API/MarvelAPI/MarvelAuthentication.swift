import Foundation
import CryptoSwift

struct MarvelAuthentication {
    
    struct ServiceParameters {
        
        static let apiKey = "apikey"
        static let hash = "hash"
        static let timestamp = "ts"
    }
    
    var urlQueryItems: [URLQueryItem] {
        
        var queryItems = [URLQueryItem]()
        
        let ts = MarvelAuthentication.timestamp()
        let hash = (ts + MarvelAPIKeys.privateKey + MarvelAPIKeys.publicKey).md5()
        let apiKey = URLQueryItem(name: ServiceParameters.apiKey, value: MarvelAPIKeys.publicKey)
        let timestamp = URLQueryItem(name: ServiceParameters.timestamp, value: ts)
        let hashItem = URLQueryItem(name: ServiceParameters.hash, value: hash)
        queryItems.append(apiKey)
        queryItems.append(timestamp)
        queryItems.append(hashItem)
        
        return queryItems
    }
    
    static func timestamp() -> String {
        
        return String(format:"%.0f", NSDate().timeIntervalSince1970)
    }
}
