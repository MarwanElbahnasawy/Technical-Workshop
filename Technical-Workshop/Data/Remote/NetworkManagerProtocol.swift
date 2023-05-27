//
//  NetworkManagerProtocol.swift
//  itestit
//
//  Created by mo_fathy on 26/05/2023.
//

import Foundation
import Alamofire

protocol NetworkManagerProtocol {
    func getData<T: Decodable>(route: Route,
                               method: HTTPMethod,
                               params: Parameters?,
                               encoding: ParameterEncoding,
                               completion: @escaping (T?,  Error?)->())
}
