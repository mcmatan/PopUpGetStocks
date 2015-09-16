//
//  InfoPopUp.swift
//  PopUpGetStocks
//
//  Created by Matan Cohen on 9/16/15.
//  Copyright (c) 2015 Matan Cohen. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class ButtonAction : NSObject {
    var title: String
    var handler : ((ButtonAction!) -> Void)!
    var color : UIColor
    init(title: String,color : UIColor, handler: ((ButtonAction!) -> Void)!) {
        self.title = title
        self.handler = handler
        self.color = color
    }
}

class InfoPopUp: UIViewController {
    static var insetFromSides = 30.0
    static var insetFromTop = 70.0
    static var lblTitleHight = 60.0
    static var titleSeperatorBackgroundColor = UIColor.grayColor()
    static var titleSeperatorHeight = 1
    static var subtitleSidesPadding = 10
    static var subtitleTopBottomPadding = 20
    
    
    var myTitle : String
    var subtitle : String
    var buttons : [ButtonAction]!
    
    var textBackground : UIView!
    var lblHeader : UILabel!
    var lblSubtitle : UILabel!
    var titleSeperatorLine : UIView!
    var grayBackground : UIView!
    
    init(myTitle : String, subtitle : String, buttons : [ButtonAction]!) {
        self.myTitle = myTitle
        self.subtitle = subtitle
        self.buttons = buttons
        super.init(nibName: nil, bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.clearColor()
        self.grayBackground = UIView.new()
        self.grayBackground.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.3)
        self.view.addSubview(self.grayBackground)
        self.grayBackground.snp_makeConstraints {[weak self] (make) -> Void in
            make.edges.equalTo(self!.view)
        }
        self.textBackground = UIView.new()
        self.textBackground.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(self.textBackground)
        self.textBackground.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.view.snp_left).offset(InfoPopUp.insetFromSides)
            make.right.equalTo(self.view.snp_right).offset(-InfoPopUp.insetFromSides)
            make.top.equalTo(self.view.snp_top).offset(InfoPopUp.insetFromTop)
        }
        
        self.lblHeader = UILabel.new()
        self.textBackground.addSubview(self.lblHeader)
        self.lblHeader.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.textBackground.snp_top)
            make.right.equalTo(self.textBackground.snp_right)
            make.left.equalTo(self.textBackground.snp_left)
            make.height.equalTo(InfoPopUp.lblTitleHight)
        }
        self.lblHeader.textAlignment = NSTextAlignment.Center
        self.lblHeader.text = self.myTitle
        
        self.titleSeperatorLine = UIView.new()
        self.titleSeperatorLine.backgroundColor = InfoPopUp.titleSeperatorBackgroundColor
        self.textBackground.addSubview(self.titleSeperatorLine)
        self.titleSeperatorLine.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.lblHeader.snp_bottom)
            make.left.equalTo(self.textBackground.snp_left)
            make.right.equalTo(self.textBackground.snp_right)
            make.height.equalTo(InfoPopUp.titleSeperatorHeight)
        }
        self.lblSubtitle = UILabel.new()
        self.lblSubtitle.textAlignment = NSTextAlignment.Center
        self.textBackground.addSubview(self.lblSubtitle)
        self.lblSubtitle.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.textBackground.snp_left).offset(InfoPopUp.subtitleSidesPadding)
            make.right.equalTo(self.textBackground.snp_right).offset(-InfoPopUp.subtitleSidesPadding)
            make.top.equalTo(self.titleSeperatorLine.snp_bottom).offset(InfoPopUp.subtitleTopBottomPadding)
            make.bottom.equalTo(self.textBackground.snp_bottom).offset(-InfoPopUp.subtitleTopBottomPadding)
        }
        self.lblSubtitle.setContentCompressionResistancePriority(1000, forAxis: UILayoutConstraintAxis.Vertical)
        self.lblSubtitle.setContentCompressionResistancePriority(1000, forAxis: UILayoutConstraintAxis.Horizontal)
        self.lblSubtitle.numberOfLines = 0
        self.lblSubtitle.text = self.subtitle
        
        self.lblSubtitle.layoutIfNeeded()
        self.textBackground.layoutIfNeeded()
        
    }
    
    
}

/*
class PopUpPresenter : NSObject{
    
    func presentPopUp(title : String, message : String , cancelButton : ButtonAction! , buttons : [ButtonAction]! , completion : (() -> Void)? ){
        var view = UIApplication.sharedApplication().keyWindow?.rootViewController
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        if let isButtons = buttons {
            for buttonAction in buttons {
                alert.addAction(UIAlertAction(title: buttonAction.title, style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
                    buttonAction.handler(buttonAction)
                }))
            }
        }
        
        if let isCancelButton = cancelButton {
            alert.addAction(UIAlertAction(title: isCancelButton.title, style: UIAlertActionStyle.Cancel, handler: { (UIAlertAction) -> Void in
                isCancelButton.handler(isCancelButton)
            }))
        }
        
        view!.presentViewController(alert, animated: true, completion: completion)
    }
}
*/