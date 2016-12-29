//
//  WebDetailViewController.swift
//  DiB News
//
//  Created by Jason McCoy on 09/6/16.
//  Copyright © 2016 Jason McCoy. All rights reserved.
//

import UIKit

class WebDetailViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!

    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        webView.loadRequest(URLRequest(url: URL(string: url!)!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
