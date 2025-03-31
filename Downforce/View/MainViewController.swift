//
//  MainViewController.swift
//  Downforce
//
//  Created by Ayush Bhople on 21/03/25.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var mainFeedTable: UITableView!
    let activityIndicator = UIActivityIndicatorView(style: .large)
    var newsArray: [MainNewsModel] = []
    var apiManager = APIManager()
    
    private let newsImageViewModel = NewsImageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        setUpActivityIndicatorView()
        apiManager.delegate = self
        apiManager.fetchMainStreamCNNNews()
        
    }

}



extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setUpTableView() {
        mainFeedTable.delegate = self
        mainFeedTable.dataSource = self
        mainFeedTable.register(UINib(nibName: "MainFeedCustomTableViewCell", bundle: nil), forCellReuseIdentifier: "MainFeedCustomCell")
        mainFeedTable.isHidden = true
    }
    
    func setUpActivityIndicatorView() {
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        activityIndicator.startAnimating()
    }
    
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
            let temp = newsArray[0].articles?[indexPath.row].urlToImage
            if let url = URL(string: temp!) {
                cell.newsImage.setImage(from: url, viewModel: self.newsImageViewModel)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 330.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}


extension MainViewController: MainNewsFetcherDelegate {
    
    func didFetchMainNews(_ apiManager: APIManager, mainNewsModel: MainNewsModel) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            if let articles = mainNewsModel.articles, !articles.isEmpty {
                self.newsArray.append(mainNewsModel)
                self.activityIndicator.stopAnimating()
                self.mainFeedTable.isHidden = false
                self.mainFeedTable.reloadData()
            }
        }
    }
    
    func didFailWithError(error: any Error) {
        print(error)
    }
    
}
