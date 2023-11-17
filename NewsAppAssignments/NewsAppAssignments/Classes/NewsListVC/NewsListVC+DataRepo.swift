//
//  NewsListVC+DataRepo.swift
//  NewsAppAssignments
//
//  Created by Waqar on 16/11/2023.
//

import Foundation
protocol NewsListVCDataRepository{
    func getNewsList(success:@escaping (NewsModel)-> Void, failure:@escaping (Error, String)-> Void)
}
class NewsListVCServiceCall:NewsListVCDataRepository{
    func getNewsList(success: @escaping (NewsModel) -> Void, failure: @escaping (Error, String) -> Void) {
        RemoteManager.shared.getNewsList(success: success, failure: failure)
    }
}
