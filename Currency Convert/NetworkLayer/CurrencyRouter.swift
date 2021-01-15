//
//  CurrenciesRouter.swift
//  Currency Convert
//
//  Created by Mahmoud Shurrab on 15/01/2021.
//

import Foundation
import Alamofire

enum CurrenciesListRouter: URLRequestConvertible {
    case get
    
    var method: HTTPMethod {
        switch self {
        case .get:
            return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .get:
            return nil
        }
    }
    
    var url: URL {
        let relativePath : String?
        switch self {
        case .get:
            relativePath = Constants.currenciesListEndpoint+Constants.accessKey
        }
        
        let url = URL(string: Constants.baseURL+(relativePath ?? ""))!
        return url
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        return try encoding.encode(urlRequest, with: parameters)
    }
}

enum CurrencyChangeRateRouter: URLRequestConvertible {
    case get
    
    var method: HTTPMethod {
        switch self {
        case .get:
            return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .get:
            return nil
        }
    }
    
    var url: URL {
        let relativePath : String?
        switch self {
        case .get:
            relativePath = Constants.currencyRateEndpoint+Constants.accessKey+"&source="+currentCurrency
        }
        
        let url = URL(string: Constants.baseURL+(relativePath ?? ""))!
        return url
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        return try encoding.encode(urlRequest, with: parameters)
    }
}
