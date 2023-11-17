//
//  NewsListVC+VM.swift
//  NewsAppAssignments
//
//  Created by Waqar on 16/11/2023.
//

import Foundation
import UIKit
extension NewsListVC{
    class ViewModel:NSObject{
        private var dataRepository: NewsListVCDataRepository?
        var articleList:[Articles]?
        var reloadTV: (() -> Void)?
        var navigateToDetailVC: ((_ data:Articles) -> Void)?
        var showErrorDialog: ((_ title:String,_ message:String) -> Void)?
        enum Configurations {
            static let newsTVCell = "NewsListTVCell"
        }
        init(dataRepository: NewsListVCDataRepository = NewsListVCServiceCall()) {
            self.dataRepository = dataRepository
        }
        func viewDidLoad() {
            DispatchQueue.main.async {
                ActivityIndicator.showSpinny()
            }
            dataRepository?.getNewsList(success: { data in
                ActivityIndicator.hideSpinny()
                self.articleList = data.articles ?? []
                self.reloadTV?()
            }, failure: { (error,message) in
                ActivityIndicator.hideSpinny()
                self.showErrorDialog?("Error",message)
            })
        }
    }
}
// MARK: - Table View Cells Configrations
extension NewsListVC.ViewModel: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleList?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Configurations.newsTVCell, for: indexPath) as? NewsListTVCell else {
            return UITableViewCell()
        }
        if let cellData = articleList?[indexPath.row] {
            cell.configure(data: cellData)
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let data = articleList?[indexPath.row]{
            navigateToDetailVC?(data)
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}



