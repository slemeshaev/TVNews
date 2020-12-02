//
//  ViewController.swift
//  TVNews
//
//  Created by Станислав Лемешаев on 02.12.2020.
//

import UIKit

class ViewController: UICollectionViewController {
    
    var apiKey = "b30a1f14-6194-4313-b9bb-572c3b59933d"
    var articles = [JSON]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let title = title else { return }
        guard let url = URL(string: "https://content.guardianapis.com/\(title.lowercased())?api-key=\(apiKey)&show-fields=thumbnail,headline,standfirst,body") else { return }
        DispatchQueue.global(qos: .userInteractive).async {
            self.fetch(url)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let newsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? NewsCell else { fatalError("Невозможно получить ячейку") }
        let newsItem = articles[indexPath.row]
        let title = newsItem["fields"]["headline"].stringValue
        let thumbnail = newsItem["fields"]["thumbnail"].stringValue
        
        newsCell.textLabel.text = title
        
        if let imageURL = URL(string: thumbnail) {
            newsCell.imageView.load(imageURL)
        }
        
        return newsCell
    }
    
    func fetch(_ url: URL) {
        if let data = try? Data(contentsOf: url) {
            articles = JSON(data)["response"]["results"].arrayValue
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        } else {
            //
        }
    }
}

