//
//  ReaderViewController.swift
//  TVNews
//
//  Created by Станислав Лемешаев on 02.12.2020.
//

import UIKit

class ReaderViewController: UIViewController {

    @IBOutlet weak var headline: UILabel!
    @IBOutlet weak var imageView: RemoteImageView!
    @IBOutlet weak var body: UITextView!
    
    var article: JSON?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let article = article else { return }
        
        body.panGestureRecognizer.allowedTouchTypes = [UITouch.TouchType.indirect.rawValue] as [NSNumber]
        body.isSelectable = true
        
        if let url = article["fields"]["thumbnail"].url {
            imageView.load(url)
            imageView.layer.borderColor = UIColor.darkGray.cgColor
            imageView.layer.borderWidth = 2
            imageView.layer.cornerRadius = 20
        }
        
        headline.text = article["fields"]["headline"].stringValue
        body.linkTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let articleBody = article["fields"]["body"].stringValue
        let formattedArticleBody = formatHTML(articleBody)
        
        if let articleBodyData = formattedArticleBody.data(using: .utf8) {
            if let bodyText = try? NSAttributedString(data: articleBodyData, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil) {
                body.attributedText = bodyText
            }
        }
    }
    
    func formatHTML(_ html: String) -> String {
        guard let wrapperURL = Bundle.main.url(forResource: "wrapper", withExtension: "html") else { return html }
        guard let wrapper = try? String(contentsOf: wrapperURL) else { return html }
        return wrapper.replacingOccurrences(of: "%@", with: html)
    }

}
