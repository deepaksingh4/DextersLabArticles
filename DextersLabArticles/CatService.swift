//
//  ClosureService.swift
//  DextersLabArticles
//
//  Created by Deepak Singh on 26/08/24.
//

import Foundation
import Alamofire

class CatService: ObservableObject  {
    
    enum UrlEndpoint: String, URLConvertible {
        func asURL() throws -> URL {
            switch self {
            case .catFacts:
                return URL(string: self.rawValue)!
            }
        }
        
        case catFacts = "https://cat-fact.herokuapp.com/facts"
    }
    
    func fetchCatFacts(completionHanlder: @escaping (([CatFatsModel]) -> Void)) {
        AF.request(UrlEndpoint.catFacts).responseDecodable(of:[CatFatsModel].self) { response in
            switch response.result {
            case .success(let cats):
                completionHanlder(cats)
                
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    func asyncFetchCatFacts() async -> [CatFatsModel] {
        do {
            let value = try await AF.request(UrlEndpoint.catFacts).serializingDecodable([CatFatsModel].self).value
            return value
        } catch {
            return []
        }
    }
}
