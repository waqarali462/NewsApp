//
//  RestAPiManager.swift
//  NewsAppAssignments
//
//  Created by Waqar on 16/11/2023.
//

import Foundation
import Alamofire
import UIKit
enum RequestHandler: URLRequestConvertible {
    case getAllNewsList(query:String,fromDate:String,sortedAT:String)
    
    var baseURL: URL {
        return URL(string: APIConstants.baseUrl)!
    }
    var httpMethod: HTTPMethod {
        switch self {
        case .getAllNewsList:
            return .get
        }
    }
    var path: String {
        switch self {
        case .getAllNewsList(let query, let fromDate, let sortedAT):
            return "everything?q=\(query)&from=\(fromDate)&sortBy=\(sortedAT)&apiKey=\(APIConstants.apiKey)"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        print(path)
        let urlString = baseURL.appendingPathComponent(path).absoluteString.removingPercentEncoding!
        let url = URL(string: urlString)
        
        var request = URLRequest(url: url!)
        request.method = httpMethod

        switch self {
        case .getAllNewsList:
            print(request)
        }
        request.timeoutInterval = 150
        return request
    }
}
class ServiceCall {
    
    static func Request<T: Decodable>(
        url: URLRequestConvertible,
        model: T.Type,
        success: @escaping (T) -> Void,
        failure: @escaping (Error, String) -> Void
    ) {
        AF.request(url)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: model.self) { response in
                switch response.result {
                case .success(let value):
                    print("Server Response Success = \(value)")
                    success(value)
                case .failure(let error):
                    if let statusCode = response.response?.statusCode {
                        switch statusCode {
                        case 400:
                            failure(error, "Bad Request. Please check your request parameters.")
                        case 401:
                            failure(error, "Unauthorized. Please log in again.")
                            // Redirect to login or show authentication screen
                        default:
                            let errorMessage = "Server Response Error (\(statusCode)). Please try again later."
                            print(errorMessage)
                            failure(error, errorMessage)
                        }
                    } else {
                        let networkErrorMessage = "Network Request Error. Please check your internet connection and try again."
                        print(networkErrorMessage)
                        failure(error, networkErrorMessage)
                    }
                }
            }
    }
}


