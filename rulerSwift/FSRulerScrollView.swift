//
//  FSRulerScrollView.swift
//  rulerSwift
//
//  Created by Albert on 16/6/4.
//  Copyright © 2016年 Albert. All rights reserved.
//

import UIKit

class FSRulerScrollView: UIScrollView {
    override init(frame: CGRect) {
        super.init(frame: frame);
   
        
        //  self.rulerScrollView?.rulerWidth = CGFloat
        
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!;
    
        fatalError("init(coder:) has not been implemented")
    }
    
    let DISTANCELEFTANDRIGHT :CGFloat = 8  //标尺左右距离
    let DISTANCEVALUE: CGFloat = 8 //刻度实际长度
    let DISTANCETOPANDBOTTOM: CGFloat = 20 //标尺上下距离
    var rulerCount: NSInteger?
    var rulerAverage: NSNumber?
    var rulerHeight: NSInteger?
    var rulerWidth: NSInteger?
    var rulerValue: Float?
    var mode: Bool?
    
   
    func drawRuler() {
        
        let pathRef1 = CGMutablePath()
        let pathRef2 = CGMutablePath()
        
        let shapeLayer1 = CAShapeLayer.init()
        shapeLayer1.strokeColor = UIColor.lightGray().cgColor
        shapeLayer1.fillColor = UIColor.clear().cgColor
        shapeLayer1.lineWidth = 1
        shapeLayer1.lineCap = kCALineCapButt
        
        let shapeLayer2 = CAShapeLayer.init()
        shapeLayer2.strokeColor = UIColor.lightGray().cgColor
        shapeLayer2.fillColor = UIColor.clear().cgColor
        shapeLayer2.lineWidth = 1
        shapeLayer2.lineCap = kCALineCapButt
        
        for index in 0...NSInteger(self.rulerCount!) {
            let rule: UILabel = UILabel.init()
            rule.textColor = UIColor.black()
            rule.text = String(format: "%.0f",Float(index) * self.rulerAverage!.floatValue)
            let ruleTextString: NSString = rule.text! as NSString
            let textSize = ruleTextString.size(attributes: [NSFontAttributeName: rule.font])
            
            if index % 10 == 0 {
                pathRef2.moveTo(nil, x:DISTANCELEFTANDRIGHT + DISTANCEVALUE * CGFloat(index)  , y: DISTANCETOPANDBOTTOM)
                pathRef2.addLineTo(nil, x:DISTANCELEFTANDRIGHT + DISTANCEVALUE * CGFloat(index) , y: CGFloat(self.rulerHeight!) - DISTANCETOPANDBOTTOM - CGFloat(textSize.height))
                rule.frame = CGRect.init(x: DISTANCELEFTANDRIGHT + DISTANCEVALUE * CGFloat(index) - textSize.width / 2, y: CGFloat(self.rulerHeight!) - DISTANCETOPANDBOTTOM - textSize.height, width: 0, height: 0)
                rule.sizeToFit()
                self.addSubview(rule)
            }
            else if index % 5 == 0 {
                pathRef1.moveTo(nil, x: DISTANCELEFTANDRIGHT + DISTANCEVALUE * CGFloat(index), y: DISTANCETOPANDBOTTOM + 10)
                pathRef1.addLineTo(nil, x:DISTANCELEFTANDRIGHT + DISTANCEVALUE * CGFloat(index) , y: CGFloat(self.rulerHeight!) - DISTANCETOPANDBOTTOM - CGFloat(textSize.height) - 10)
            }
            else {
                pathRef1.moveTo(nil, x: DISTANCELEFTANDRIGHT + DISTANCEVALUE * CGFloat(index), y: DISTANCETOPANDBOTTOM + 20)
                pathRef1.addLineTo(nil, x:DISTANCELEFTANDRIGHT + DISTANCEVALUE * CGFloat(index) , y: CGFloat(self.rulerHeight!) - DISTANCETOPANDBOTTOM - CGFloat(textSize.height) - 20)
            }
        }
        
        shapeLayer1.path = pathRef1
        shapeLayer2.path = pathRef2
        
        self.layer.addSublayer(shapeLayer1)
        self.layer.addSublayer(shapeLayer2)
        
        self.frame = CGRect.init(x: 0, y: 0, width: self.rulerWidth!, height: self.rulerHeight!)
        
        //开启最小模式
        if self.mode! {
            let edge: UIEdgeInsets = UIEdgeInsetsMake(0, CGFloat(self.rulerWidth! / 2) - DISTANCELEFTANDRIGHT, 0, CGFloat(self.rulerWidth! / 2) - DISTANCELEFTANDRIGHT)
            self.contentInset = edge
            self.contentOffset = CGPoint.init(x: DISTANCEVALUE * (CGFloat(self.rulerValue!) / CGFloat(self.rulerAverage!) - CGFloat(self.rulerWidth!) + CGFloat(self.rulerWidth! / 2) + DISTANCELEFTANDRIGHT), y: 0)
            
        }
        else {
            let edge: UIEdgeInsets = UIEdgeInsetsMake(0, CGFloat(self.rulerWidth! / 2) - DISTANCELEFTANDRIGHT, 0, CGFloat(self.rulerWidth! / 2) - DISTANCELEFTANDRIGHT)
            self.contentInset = edge
            self.contentOffset = CGPoint.init(x: DISTANCEVALUE * (CGFloat(self.rulerValue!) / CGFloat(self.rulerAverage!) - CGFloat(self.rulerWidth! / 2) + DISTANCELEFTANDRIGHT), y: 0)
            
        }
        
        self.contentSize = CGSize.init(width: CGFloat(self.rulerCount!) * DISTANCEVALUE + DISTANCELEFTANDRIGHT * 2, height: CGFloat(self.rulerHeight!))
        
    }

}
