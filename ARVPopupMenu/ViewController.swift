//
//  ViewController.swift
//  ARVPopupMenu
//
//  Created by Arvindh Sukumar on 08/03/15.
//  Copyright (c) 2015 Arvindh Sukumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var menu: ARVPopupMenu!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.setToolbarHidden(false, animated: false)
        
        let button = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        button.frame = CGRectMake(0, 0, 60, 44)
        button.setTitle("Show", forState: UIControlState.Normal)
        let tap = UITapGestureRecognizer(target: self, action: "showMenu:")
        button.addGestureRecognizer(tap)
        let bb1 = UIBarButtonItem(customView: button)
        
        let flexiSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        self.setToolbarItems([bb1], animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func showMenu(sender:UITapGestureRecognizer){
        
        let view = sender.view
        
        if self.menu == nil {
            let item1 = ARVPopupMenuItem(title: "Home 5", image: nil)
            let item2 = ARVPopupMenuItem(title: "Home 2", image: nil)
            let item3 = ARVPopupMenuItem(title: "Home 3", image: nil)
            self.menu = ARVPopupMenu(items: [item1,item2, item3])
        }
        if !self.menu.isVisible {
            menu.showMenu(view!, inView: self.view)

        }
        else {
            menu.hideMenu()
        }
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        self.menu.tableView.reloadData()
        println(self.menu.frame)
        self.menu.tableView.bounds = self.menu.bounds

        println(self.menu.tableView.bounds)
    }
}

