//
//  PrivacyPolicyViewController.swift
//  Bwin
//
//  Created by Tanya Koldunova on 24.10.2022.
//

import UIKit
import WebKit

class PrivacyPolicyViewController: UIViewController {
    
    private var url: URL
    
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let webView = WKWebView(frame: self.view.bounds)
        webView.load(URLRequest(url: url))
        self.view.addSubview(webView)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
