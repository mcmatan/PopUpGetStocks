//
//  ViewController.swift
//  PopUpGetStocks
//
//  Created by Matan Cohen on 9/16/15.
//  Copyright (c) 2015 Matan Cohen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
                self.view.backgroundColor = UIColor.redColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    @IBAction func btnPress(sender: AnyObject) {
        
        var okBtn = ButtonAction(title: "YES", color: UIColor.greenColor()) { (ButtonAction) -> Void in
            println("Ok")
        }
        var cancelBtn = ButtonAction(title: "GO BACK", color: UIColor.grayColor()) { (ButtonAction) -> Void in
            println("cancelBtn")
        }

        var subtitle = "blabla bla blabla bla blabla bla blabla bla blabla bla blabla bla blabla bla bla boihoihoihoihlabla bla blabla bla blabla bla blabla bla blabla bla  bla blabla bla blabla bla blabla bla blabla bla blabla bla  bla blabla bla blabla bla blabla bla blabla bla blabla bla  bla blabla bla blabla bla blabla bla blabla bla blabla bla  bla blabl "
        var attSubtitle = NSAttributedString(string: subtitle)
        
//        var vc = InfoPopUp(myTitle: "Some title", subtitle: subtitle, buttonsActions: [okBtn, cancelBtn])
        
        var vc = InfoPopUp(myTitle: "Some title", attSubtitle: attSubtitle, buttonsActions: [okBtn, cancelBtn])
        
        self.providesPresentationContextTransitionStyle = true;
        self.definesPresentationContext = true;
        vc.modalPresentationStyle = UIModalPresentationStyle.Custom
        
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
}

