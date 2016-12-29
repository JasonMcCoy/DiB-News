//
//  ViewController.swift
//  DiB News
//
//  Created by Jason McCoy on 09/6/16.
//  Copyright © 2016 Jason McCoy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var articles:[Article]? = []
    
    var source = "engadget"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fetchArticles(fromSource: source)
    }

    func fetchArticles(fromSource provider: String) {
        // Create a URL Request and unwrap
        let urlRequest = URLRequest(url: URL(string: "https://newsapi.org/v1/articles?source=\(provider)&sortBy=top&apiKey=8fefc4d3bfbf4e2bb651379d98422d86")!)
        // Create a tasks URLSession& download things from the http - data is the JSON ,
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            // check error
            if error != nil {
                print(error!)
                return
            }
            
            // Init articles array so that It can create the object
            self.articles = [Article]()
            
            // JSON - try catch - transfer to an Dictionary like [author : "balbalbal"]
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]

                
                if let articlesArrayFromJson = json["articles"] as? [[String : AnyObject]] {
                    // For every article 
                    // MARK: For in Loop - Get the JSON Data
                    for articleArrayFromJson in articlesArrayFromJson {
                        // set article object
                        let article = Article()
                        if let title = articleArrayFromJson["title"] as? String,
//                           let author = articleArrayFromJson["author"] as? String,
                           let desc = articleArrayFromJson["description"] as? String,
                           let url = articleArrayFromJson["url"] as? String,
                           let urlToImage = articleArrayFromJson["urlToImage"] as? String {
//                                article.author = author
                                article.desc = desc
                                article.title = title
                                article.url = url
                                article.imageUrl = urlToImage
                        } else {
//                            article.author = "Null"
                            article.desc = "Null"
                            article.title = "Null"
                            article.url = "Null"
                            article.imageUrl = "Null"
                        }
//                        if let author = articleArrayFromJson["author"] as? String {
//                            article.author = author
//                        } else {
//                            article.author = "Unknown"
//                        }
                        
                        self.articles?.append(article)
                    }
                    
                    // Reload Data of the TableView - Go to the Main Thread
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            } catch let error{
                print(error)
            }
        }
        // URLSession
        task.resume()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Cell
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        cell.title.text = self.articles?[indexPath.item].title
        cell.desc.text = self.articles?[indexPath.item].desc
        //cell.author.text = self.articles?[indexPath.item].author
        cell.imgView.downLoadImage(from: (self.articles?[indexPath.item].imageUrl)!)
        
        return cell
    }

    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // here is the json articles.count == nil 0
        return self.articles?.count ?? 0
    }
    
    
    // Get the url of the Array and pass to webDetailVC
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "web") as! WebDetailViewController
        webVC.url = self.articles?[indexPath.item].url
        self.present(webVC, animated: true, completion: nil)
    }
    
    
    
    // MARK: Menu
    let menuManager = MenuManager()
    @IBAction func menuClicked(_ sender: UIBarButtonItem) {
        menuManager.openMenu()
        menuManager.mainVC = self
    }
    


}

// Set the Image Based on the URl
extension UIImageView {
    func downLoadImage(from url: String) {
        let urlRequest = URLRequest(url: URL(string: url)!)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response,error) in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
        task.resume()
    }
}






















