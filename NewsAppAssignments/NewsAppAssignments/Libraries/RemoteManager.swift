//
//  RemoteManager.swift
//  NewsAppAssignments
//
//  Created by Waqar on 16/11/2023.
//

import Foundation
class RemoteManager: NSObject {
    
    static var shared = RemoteManager()

    func getNewsList(success:@escaping (NewsModel)-> Void, failure:@escaping (Error, String)-> Void)
    {
        ServiceCall.Request(url: RequestHandler.getAllNewsList(query: "tesla", fromDate: "2023-10-16", sortedAT:"publishedAt"), model: NewsModel.self, success: { data in
            success(data)
        }, failure: { error,message in
            failure(error,message)
        })
        
    }
}
