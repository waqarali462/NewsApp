//
//  APiConstant.swift
//  NewsAppAssignments
//
//  Created by Waqar on 16/11/2023.
//

import Foundation
public enum APIConstants {
    
    private enum ServerPath:String{
        case serverURL = "https://newsapi.org/v2/"
    }
    public static let baseUrl = ServerPath.serverURL.rawValue
    public static let apiKey = "7f24339b9c2940a481c81dbc961e11b1"
}
