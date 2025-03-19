//
//  ViewController.swift
//  Downforce
//
//  Created by Ayush Bhople on 16/03/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var totalCount: UILabel!
    
    var apiManager = APIManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiManager.delegate = self
        
        apiManager.fetchMainStreamCNNNews()
        
    }


}


extension ViewController: MainNewsFetcherDelegate {
    func didFetchMainNews(_ apiManager: APIManager, mainNewsModel: MainNewsModel) {
        DispatchQueue.main.async {
            self.totalCount.text = "\(mainNewsModel.totalResults ?? 0)"
        }
    }
    
    func didFailWithError(error: any Error) {
        
    }
    
    
}

