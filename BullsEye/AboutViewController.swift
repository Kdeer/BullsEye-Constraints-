//
//  AboutViewController.swift
//  BullsEye
//
//  Created by Xiaochao Luo on 2016-09-26.
//  Copyright © 2016 Xiaochao Luo. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var aIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = Bundle.main.url(forResource: "BullsEye",
                                     withExtension: "html") {
            aIndicator.startAnimating()
            if let htmlData = try? Data(contentsOf: url) {
                let baseURL = URL(fileURLWithPath: Bundle.main.bundlePath)
                webView.load(htmlData, mimeType: "text/html",
                             textEncodingName: "UTF-8", baseURL: baseURL)
            }
            aIndicator.stopAnimating()
            aIndicator.isHidden = true
        }
        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func close(_ sender: AnyObject) {
        dismiss(animated: true, completion: {completed in
            print("we did it")
        })
    }
    
    

}
