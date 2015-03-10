//
//  ARVPopupMenu.swift
//  ARVPopupMenu
//
//  Created by Arvindh Sukumar on 08/03/15.
//  Copyright (c) 2015 Arvindh Sukumar. All rights reserved.
//

import UIKit

let kPopupMenuCellIdentifier = "PopupCell"

class ARVPopupMenu: UIView, UITableViewDataSource, UITableViewDelegate {
    var items:[ARVPopupMenuItem] = []
    let itemHeight: CGFloat = 40
    var tableView: UITableView!
    var isVisible: Bool = false
    var tapGR: UITapGestureRecognizer!
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        // Drawing code
    }
    */
    
    convenience init(items:[ARVPopupMenuItem]) {
        self.init()
        self.items = items
        self.setup()
    }

    func setup(){
        self.tapGR = UITapGestureRecognizer(target: self, action: "hideMenuOnTap:")

        let height = (CGFloat(self.items.count) * self.itemHeight)
        self.frame = CGRectMake(0, 0, 140, height)
        self.autoresizingMask = UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleRightMargin
        
        let outerView = UIView(frame: self.frame)
        outerView.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
        outerView.backgroundColor = UIColor.clearColor()
        outerView.layer.shadowColor = UIColor(white: 0.2, alpha: 1).CGColor
        outerView.layer.shadowRadius = 2.0
        outerView.layer.shadowOffset = CGSizeMake(0, 1)
        outerView.layer.shadowOpacity = 1
        
        
        let innerView = UIView(frame: self.frame)
        innerView.backgroundColor = UIColor(white: 0.3, alpha: 1)
        innerView.layer.cornerRadius = 4
        innerView.layer.masksToBounds = true
        innerView.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
        
        
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Dark))

        blur.frame = self.bounds

        
        
        self.tableView = UITableView(frame: innerView.frame, style: UITableViewStyle.Plain)
        self.tableView.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = UIColor.clearColor()
//        self.tableView.backgroundView = blur
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.scrollEnabled = false

        self.tableView.registerNib(UINib(nibName: "ARVPopupMenuCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: kPopupMenuCellIdentifier)
        
        innerView.addSubview(self.tableView)
        
        outerView.addSubview(innerView)
        
        self.addSubview(outerView)
        self.tableView.reloadData()

    
    }
    
    
    func showMenu(fromView:UIView, inView:UIView){

        let fromFrame = inView.convertRect(fromView.bounds, fromView: fromView)
        var selfFrame = self.frame
        selfFrame.origin.x = fromFrame.origin.x
        selfFrame.origin.y = inView.frame.size.height
        self.frame = selfFrame
        inView.addSubview(self)
//        inView.userInteractionEnabled = false
        inView.addGestureRecognizer(self.tapGR)
        
        UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 0.6, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            selfFrame.origin.y = fromFrame.origin.y - 10 - selfFrame.size.height
            self.frame = selfFrame
            self.setNeedsLayout()
            
            }) { (finished:Bool) -> Void in
                self.isVisible = true

        }
        
        println(fromFrame)

    }
    
    func hideMenu(){
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            var selfFrame = self.frame
            selfFrame.origin.y = self.superview!.frame.size.height
            self.frame = selfFrame
            
            }) { (finished:Bool) -> Void in

                self.superview?.userInteractionEnabled = true
                self.superview?.removeGestureRecognizer(self.tapGR)
                self.removeFromSuperview()
                self.isVisible = false
        }
    }
    
    func hideMenuOnTap(tap:UITapGestureRecognizer){
        self.hideMenu()
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.itemHeight
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kPopupMenuCellIdentifier, forIndexPath: indexPath) as ARVPopupMenuCell
        
        let item = self.items[indexPath.row]
        cell.label.text = item.title
        cell.iconImageView.image = nil
        cell.contentView.backgroundColor = UIColor.clearColor()
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }
}
