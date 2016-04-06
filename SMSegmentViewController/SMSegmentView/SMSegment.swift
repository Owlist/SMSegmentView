//
//  SMSegment.swift
//
//  Created by Si MA on 03/01/2015.
//  Copyright (c) 2015 Si Ma. All rights reserved.
//

import UIKit

public class SMSegment: SMBasicSegment {
    
    // UI Elements
    override public var frame: CGRect {
        didSet {
            self.resetContentFrame()
        }
    }
    
    public var verticalMargin: CGFloat = 5.0 {
        didSet {
            self.resetContentFrame()
        }
    }
        
    // Segment Colour
    public var onSelectionColour: UIColor = UIColor.darkGrayColor() {
        didSet {
            if self.isSelected == true {
                self.backgroundColor = self.onSelectionColour
            }
        }
    }
    public var offSelectionColour: UIColor = UIColor.whiteColor() {
        didSet {
            if self.isSelected == false {
                self.backgroundColor = self.offSelectionColour
            }
        }
    }
    private var willOnSelectionColour: UIColor! {
        get {
            var hue: CGFloat = 0.0
            var saturation: CGFloat = 0.0
            var brightness: CGFloat = 0.0
            var alpha: CGFloat = 0.0
            self.onSelectionColour.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
            return UIColor(hue: hue, saturation: saturation*0.5, brightness: min(brightness*1.5, 1.0), alpha: alpha)
        }
    }
    
    // Segment Title Text & Colour & Font
    public var title: String? {
        didSet {
            self.titleLabel.text = self.title
            
            if let titleText = self.titleLabel.text as NSString? {
                self.labelWidth = titleText.boundingRectWithSize(CGSize(width: self.frame.size.width, height: self.frame.size.height), options:NSStringDrawingOptions.UsesLineFragmentOrigin , attributes: [NSFontAttributeName: self.titleLabel.font], context: nil).size.width
            }
            else {
                self.labelWidth = 0.0
            }
            
            self.resetContentFrame()
        }
    }
    public var subtitle: String? {
        didSet {
            self.subtitleLabel.text = self.subtitle
            
            if let subtitleText = self.subtitleLabel.text as NSString? {
                self.labelWidth = subtitleText.boundingRectWithSize(CGSize(width: self.frame.size.width, height: self.frame.size.height), options:NSStringDrawingOptions.UsesLineFragmentOrigin , attributes: [NSFontAttributeName: self.subtitleLabel.font], context: nil).size.width
            }
            else {
                self.labelWidth = 0.0
            }
            
            self.resetContentFrame()
        }
    }
    
    public var onSelectionTextColour: UIColor = UIColor.whiteColor() {
        didSet {
            if self.isSelected == true {
                self.titleLabel.textColor = self.onSelectionTextColour
                self.subtitleLabel.textColor = self.onSelectionTextColour
            }
        }
    }
    
    public var offSelectionTextColour: UIColor = UIColor.darkGrayColor() {
        didSet {
            if self.isSelected == false {
                self.titleLabel.textColor = self.offSelectionTextColour
                self.subtitleLabel.textColor = self.offSelectionTextColour
            }
        }
    }
    
    public var titleFont: UIFont = UIFont.systemFontOfSize(17.0) {
        didSet {
            self.titleLabel.font = self.titleFont
            
            if let titleText = self.titleLabel.text as NSString? {
                self.labelWidth = titleText.boundingRectWithSize(CGSize(width: self.frame.size.width + 1.0, height: self.frame.size.height), options:NSStringDrawingOptions.UsesLineFragmentOrigin , attributes: [NSFontAttributeName: self.titleLabel.font], context: nil).size.width
            }
            else {
                self.labelWidth = 0.0
            }
            
            self.resetContentFrame()
        }
    }
    public var subtitleFont: UIFont = UIFont.systemFontOfSize(14.0) {
        didSet {
            self.subtitleLabel.font = self.subtitleFont
            
            if let titleText = self.subtitleLabel.text as NSString? {
                self.labelWidth = titleText.boundingRectWithSize(CGSize(width: self.frame.size.width + 1.0, height: self.frame.size.height), options:NSStringDrawingOptions.UsesLineFragmentOrigin , attributes: [NSFontAttributeName: self.subtitleLabel.font], context: nil).size.width
            }
            else {
                self.labelWidth = 0.0
            }
            
            self.resetContentFrame()
        }
    }
    
    // Segment Image
    public var onSelectionImage: UIImage? {
        didSet {
            if self.onSelectionImage != nil {
                self.resetContentFrame()
            }
            if self.isSelected == true {
                self.imageView.image = self.onSelectionImage
            }
        }
    }
    public var offSelectionImage: UIImage? {
        didSet {
            if self.offSelectionImage != nil {
                self.resetContentFrame()
            }
            if self.isSelected == false {
                self.imageView.image = self.offSelectionImage
            }
        }
    }
    
   
    private var imageView: UIImageView = UIImageView()
    private var titleLabel: UILabel = UILabel()
    private var subtitleLabel: UILabel = UILabel()
    private var labelWidth: CGFloat = 0.0
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(verticalMargin: CGFloat, onSelectionColour: UIColor, offSelectionColour: UIColor, onSelectionTextColour: UIColor, offSelectionTextColour: UIColor, titleFont: UIFont, subtitleFont: UIFont) {
        
        self.verticalMargin = verticalMargin
        self.onSelectionColour = onSelectionColour
        self.offSelectionColour = offSelectionColour
        self.onSelectionTextColour = onSelectionTextColour
        self.offSelectionTextColour = offSelectionTextColour
        self.titleFont = titleFont
        self.subtitleFont = subtitleFont
        
        super.init(frame: CGRectZero)
        self.setupUIElements()
    }
    
    
    
    func setupUIElements() {
        
        self.backgroundColor = self.offSelectionColour
        
        self.imageView.contentMode = UIViewContentMode.ScaleAspectFit
        self.addSubview(self.imageView)
        
        self.titleLabel.textAlignment = NSTextAlignment.Center
        self.titleLabel.font = self.titleFont
        self.titleLabel.textColor = self.offSelectionTextColour
        self.titleLabel.hidden = true
        self.titleLabel.backgroundColor = UIColor.cyanColor()

        self.addSubview(self.titleLabel)
        
        self.subtitleLabel.textAlignment = NSTextAlignment.Center
        self.subtitleLabel.font = self.subtitleFont
        self.subtitleLabel.textColor = self.offSelectionTextColour
        self.subtitleLabel.hidden = true
        self.subtitleLabel.backgroundColor = UIColor.cyanColor()

        self.addSubview(self.subtitleLabel)
    }
    
    
    // MARK: Update Frame
    private func resetContentFrame() {
        
//        var distanceBetween: CGFloat = 0.0
        var imageViewFrame = CGRectMake(0.0, self.verticalMargin, 0.0, self.frame.size.height - self.verticalMargin*2)
        
        if self.onSelectionImage != nil || self.offSelectionImage != nil {
            // Set imageView as a square
            imageViewFrame.size.width = self.frame.size.height - self.verticalMargin*2
//            distanceBetween = 5.0
        }
        
        // If there's no text, align imageView centred
        // Else align text centred
//        if self.labelWidth == 0.0 {
            imageViewFrame.origin.x = max((self.frame.size.width - imageViewFrame.size.width) / 2.0, 0.0)
//        }
//        else {
//            imageViewFrame.origin.x = max((self.frame.size.width - imageViewFrame.size.width - self.labelWidth) / 2.0 - distanceBetween, 0.0)
//        }
        
        self.imageView.frame = imageViewFrame
        
        self.titleLabel.frame = CGRectMake(0, self.frame.size.height/4, self.labelWidth, self.frame.size.height/2)
        
        self.subtitleLabel.frame = CGRectMake(0, 0.75 * self.frame.size.height, self.labelWidth, self.frame.size.height/4)
        
    }
    
    // MARK: Selections
    override public func setSelected(selected: Bool, inView view: SMBasicSegmentView) {
        super.setSelected(selected, inView: view)
        if selected {
            self.backgroundColor = self.onSelectionColour
            self.titleLabel.textColor = self.onSelectionTextColour
            self.subtitleLabel.textColor = self.onSelectionTextColour
            self.imageView.image = nil
            self.titleLabel.hidden = false
            self.subtitleLabel.hidden = false
        }
        else {
            self.backgroundColor = self.offSelectionColour
            self.titleLabel.textColor = self.offSelectionTextColour
            self.subtitleLabel.textColor = self.offSelectionTextColour
            self.imageView.image = self.offSelectionImage
            self.titleLabel.hidden = true
            self.subtitleLabel.hidden = true
        }
    }
    
    // MARK: Handle touch
    override public  func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        if self.isSelected == false {
            self.backgroundColor = self.willOnSelectionColour
        }
    }
    
}