//
//  MainViewController.swift
//  Downforce
//
//  Created by Ayush Bhople on 21/03/25.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var mainFeedTable: UITableView!
    var newsArray: [MainNewsModel] = []
    var apiManager = APIManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainFeedTable.delegate = self
        mainFeedTable.dataSource = self
        
        apiManager.delegate = self
        
        mainFeedTable.register(UINib(nibName: "MainFeedCustomTableViewCell", bundle: nil), forCellReuseIdentifier: "MainFeedCustomCell")
        
        apiManager.fetchMainStreamCNNNews()
        
    }

}



extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (newsArray.count > 0 && newsArray[0].articles != nil) {
            return newsArray[0].articles?.count ?? 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainFeedCustomCell", for: indexPath) as! MainFeedCustomTableViewCell
        
        if (newsArray.count == 0){
            cell.newsTitle.text = "Loading..."
        } else {
            cell.newsTitle.text = newsArray[0].articles?[indexPath.row].title
        }
        
        return cell
    }
    
}


extension MainViewController: MainNewsFetcherDelegate {
    
    func didFetchMainNews(_ apiManager: APIManager, mainNewsModel: MainNewsModel) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            if let articles = mainNewsModel.articles, !articles.isEmpty {
                self.newsArray.append(mainNewsModel)
                self.mainFeedTable.reloadData()
            }
        }
    }
    
    func didFailWithError(error: any Error) {
        print(error)
    }
    
}
