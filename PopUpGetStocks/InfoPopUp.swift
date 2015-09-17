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
    static var titleSeperatorBackgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.3)
    static var titleSeperatorHeight = 1
    static var subtitleSidesPadding = 10
    static var subtitleTopBottomPadding = 20
    static var btnsHeight = 47
    static var spacingBetweenButtonsAndText = 9
    static var corderRaius = 3.0
    
    
    var myTitle : String
    var subtitle : String!
    var attSubtitle : NSAttributedString!
    var buttonsActions : [ButtonAction]!
    
    var textBackground : UIView!
    var lblHeader : UILabel!
    var lblSubtitle : UILabel!
    var titleSeperatorLine : UIView!
    var grayBackground : UIView!
    var buttonsViews : Array<UIButton>!
    
    init(myTitle : String, subtitle : String, buttonsActions : [ButtonAction]!) {
        self.myTitle = myTitle
        self.subtitle = subtitle
        self.buttonsActions = buttonsActions
        super.init(nibName: nil, bundle: nil)
    }
    
    init(myTitle : String, attSubtitle : NSAttributedString, buttonsActions : [ButtonAction]!) {
        self.myTitle = myTitle
        self.attSubtitle = attSubtitle
        self.buttonsActions = buttonsActions
        super.init(nibName: nil, bundle: nil)
    }


    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.placeAllViews()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.fadeInBackground()
        self.showViewsWithAnimation()
    }
    
    func placeAllViews() {
        self.view.backgroundColor = UIColor.clearColor()
        self.grayBackground = UIView.new()
        self.grayBackground.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        self.view.addSubview(self.grayBackground)
        self.grayBackground.snp_makeConstraints {[weak self] (make) -> Void in
            make.edges.equalTo(self!.view)
        }
        self.textBackground = UIView.new()
        self.setDefaultCorderRadiusForView(self.textBackground)
        self.textBackground.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(self.textBackground)
        self.textBackground.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.view.snp_left).offset(InfoPopUp.insetFromSides)
            make.right.equalTo(self.view.snp_right).offset(-InfoPopUp.insetFromSides)
            make.top.equalTo(self.view.snp_top).offset(UIScreen.mainScreen().bounds.height)
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
        self.lblSubtitle.setContentCompressionResistancePriority(UILayoutPriority(UIScreen.mainScreen().bounds.height), forAxis: UILayoutConstraintAxis.Vertical)
        self.lblSubtitle.setContentCompressionResistancePriority(UILayoutPriority(UIScreen.mainScreen().bounds.height), forAxis: UILayoutConstraintAxis.Horizontal)
        self.lblSubtitle.numberOfLines = 0
        
        if let isSubtitle = self.subtitle {
                self.lblSubtitle.text = isSubtitle
        } else {
            self.lblSubtitle.attributedText = attSubtitle
        }
        
        self.buttonsViews = Array<UIButton>()
        var lastButton : UIButton!
        if let isButtonsActions = self.buttonsActions {
        } else {
            return
        }
        for  btnAction in self.buttonsActions  {
            var button = UIButton()
            button.backgroundColor = btnAction.color
            button.setTitle(btnAction.title, forState: UIControlState.Normal)
            button.addAction(UIControlEvents.TouchUpInside, block: {[weak self] (UIControl) -> Void in
                self?.dissmissWithAnimation()
                btnAction.handler(btnAction)
                })
            self.view.addSubview(button)
            
            if let isLastButton = lastButton {
                button.snp_makeConstraints(closure: { (make) -> Void in
                    make.top.equalTo(lastButton.snp_bottom).offset(10)
                    make.left.equalTo(self.textBackground.snp_left)
                    make.right.equalTo(self.textBackground.snp_right)
                    make.height.equalTo(InfoPopUp.btnsHeight)
                })
            } else {
                button.snp_makeConstraints(closure: { (make) -> Void in
                    make.top.equalTo(UIScreen.mainScreen().bounds.size.height)
                    make.left.equalTo(self.textBackground.snp_left)
                    make.right.equalTo(self.textBackground.snp_right)
                    make.height.equalTo(InfoPopUp.btnsHeight)
                })
            }
            
            self.setDefaultCorderRadiusForView(button)
            buttonsViews.append(button)
            lastButton = button
            
            
        }
    }
    
    func setDefaultCorderRadiusForView( view : UIView ) {
        view.layer.cornerRadius = CGFloat(InfoPopUp.corderRaius)
        view.layer.masksToBounds = false
    }
    
    func showViewsWithAnimation() {
        self.textBackground.snp_updateConstraints { (make) -> Void in
            make.top.equalTo(self.view.snp_top).offset(InfoPopUp.insetFromTop)
        }
        
        UIView.animateWithDuration(1.0, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.textBackground.layoutIfNeeded()
            }, completion: nil)

        
        var lastButton : UIButton!
        var delay = 0.3
        var buttonAnimDuration = 1.0
        for buttonView in buttonsViews {
            
                if let isLastButton = lastButton {
                    buttonView.snp_remakeConstraints(closure: { (make) -> Void in
                        make.top.equalTo(lastButton.snp_bottom).offset(InfoPopUp.spacingBetweenButtonsAndText)
                        make.left.equalTo(self.textBackground.snp_left)
                        make.right.equalTo(self.textBackground.snp_right)
                        make.height.equalTo(InfoPopUp.btnsHeight)
                        
                    })
                } else {
                    buttonView.snp_remakeConstraints(closure: { (make) -> Void in
                        make.top.equalTo(self.textBackground.snp_bottom).offset(InfoPopUp.spacingBetweenButtonsAndText)
                        make.left.equalTo(self.textBackground.snp_left)
                        make.right.equalTo(self.textBackground.snp_right)
                        make.height.equalTo(InfoPopUp.btnsHeight)
                    })
            }
                lastButton = buttonView
            
            UIView.animateWithDuration(buttonAnimDuration, delay: delay, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                buttonView.layoutIfNeeded()
            }, completion: nil)
            
            delay += 0.1
            buttonAnimDuration += 0.1
        }
    }
    
    
    func hideViewsWithAnimation(duration : Float) {
        self.textBackground.snp_updateConstraints {[weak self] (make) -> Void in
            make.top.equalTo(UIScreen.mainScreen().bounds.height)
        }
        UIView.animateWithDuration(NSTimeInterval(duration), delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    func fadeInBackground() {
        UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.grayBackground.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        }, completion: nil)
    }
    
    func fadeOutBackground(duration : Float) {
        UIView.animateWithDuration(NSTimeInterval(duration), animations: { () -> Void in
            self.grayBackground.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            }, completion: nil)
    }
    
    func dissmissWithAnimation() {
        
        self.hideViewsWithAnimation(0.6)
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW,
            Int64(0.1 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.fadeOutBackground(0.3)
        }

        let delayTimeDissmiss = dispatch_time(DISPATCH_TIME_NOW,
            Int64(0.6 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTimeDissmiss, dispatch_get_main_queue()) {
            self.dismissViewControllerAnimated(false, completion: nil)
        }
    }
}
