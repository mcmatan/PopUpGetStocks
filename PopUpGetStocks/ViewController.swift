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
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.view.backgroundColor = UIColor.redColor()
        
        var vc = InfoPopUp(myTitle: "Some title", subtitle: "blabla bla blabla bla blabla bla blabla bla blabla bla blabla bla blabla bla bla blabla bla blabla bla blabla bla blabla bla blabla bla  bla blabla bla blabla bla blabla bla blabla bla blabla bla  bla blabla bla blabla bla blabla bla blabla bla blabla bla  bla blabla bla blabla bla blabla bla blabla bla blabla bla  bla blabla bla blabla bla blabla bla blabla bla blabla bla  bla blabla bla blabla bla blabla bla blabla bla blabla bla  bla blabla bla blabla bla blabla bla blabla bla blabla bla bla blabla bla blabla bla blabla bla blabla bla blabla bla ", buttons: nil)
        
        self.providesPresentationContextTransitionStyle = true;
        self.definesPresentationContext = true;
        vc.modalPresentationStyle = UIModalPresentationStyle.Custom
        
        self.presentViewController(vc, animated: true, completion: nil)
    }

}

