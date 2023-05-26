//
//  APIServices.swift
//  itestit
//
//  Created by mo_fathy on 26/05/2023.
//

//MARK: -  alamofire + decoder
import Alamofire
import Foundation


//MARK: - Route

enum Route {
    static let baseUrl = "https://tasty.p.rapidapi.com/recipes"
    
    case listSimilarities
    case list
    var description: String {
        switch self {
        case .listSimilarities:
            return "\(Route.baseUrl)/list-similarities"
        case .list:
            return "\(Route.baseUrl)/list"
        }
    }
}


class APIServices: NetworkManagerProtocol {
    private init() {}
    static let instance = APIServices()
 
    let header : [String: String] = [
        "X-RapidAPI-Key": "d67902112amshdb94118d744b893p18293bjsn4d056e614259",
        "X-RapidAPI-Host": "tasty.p.rapidapi.com"
    ]
    
    //MARK: - getData
    func getData<T: Decodable>(route: Route, method: HTTPMethod ,params: Parameters?, encoding: ParameterEncoding ,completion: @escaping (T?,  Error?)->()) {
        Alamofire.request(route.description, method: method, parameters: params, encoding: encoding, headers: header)
            .validate(statusCode: 200...300)
            .responseJSON { (response) in
                switch response.result {
                case .success(_):
                    guard let data = response.data else { return }
                    do {
                        let jsonData = try JSONDecoder().decode(T.self, from: data)
                        completion(jsonData,  nil)
                    } catch let jsonError {
                        print(jsonError)
                    }
                case .failure(let error):
                    completion(nil,  error)
                }
            }
    }
}
