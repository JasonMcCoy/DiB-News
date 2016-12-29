//
//  MenuManager.swift
//  DiB News
//
//  Created by Jason McCoy on 09/6/16.
//  Copyright © 2016 Jason McCoy. All rights reserved.
//

import UIKit

class MenuManager: NSObject, UITableViewDelegate, UITableViewDataSource {

    let blackShadeView = UIView()
    let menuTableView = UITableView()
    let arrayOfSources = ["TIME", "CNN", "Engadget", "National-geographic","The-economist","Google-news"]
    var mainVC: ViewController?
    
    
    public func openMenu() {
        // Get the window from the delegate
        if let window = UIApplication.shared.keyWindow {
            blackShadeView.frame = window.frame
            blackShadeView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            blackShadeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.disMissMenu)))
            
            let heightOfTheTableView:CGFloat = 300
            let y = window.frame.height - heightOfTheTableView
            menuTableView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: heightOfTheTableView)
            
            window.addSubview(blackShadeView)
            window.addSubview(menuTableView)
            
            // Animate to Show the menu
            UIView.animate(withDuration: 0.5, animations: {
                self.blackShadeView.alpha = 1
                self.menuTableView.frame.origin.y = y
            })
        }
    }

    
    public func disMissMenu() {
        UIView.animate(withDuration: 0.5, animations: {
            self.blackShadeView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.menuTableView.frame.origin.y = window.frame.height
            }
            
        })
    }
    
    
    // MARK: Configure the Menu TableViewCell
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfSources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = arrayOfSources[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    // pass source value to mainVC(ViewController)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = mainVC {
            vc.source = arrayOfSources[indexPath.item].lowercased()
            vc.fetchArticles(fromSource: arrayOfSources[indexPath.item].lowercased())
            disMissMenu()
        }
    }
    
    override init() {
        super.init()
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.isScrollEnabled = false
        menuTableView.bounces = false
        menuTableView.register(MenuManagerViewCell.classForCoder(), forCellReuseIdentifier: "menuCell")
    }
    
}
