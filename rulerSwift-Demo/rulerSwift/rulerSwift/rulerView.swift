//
//  rulerView.swift
//  rulerSwift
//
//  Created by Albert on 16/6/4.
//  Copyright © 2016年 Albert. All rights reserved.
//

import UIKit


@objc protocol FSRulerDelegate {
    //声明方法
   @objc optional func fsRuler(_ rulerScrollView: FSRulerScrollView)
}


class rulerView: UIView, FSRulerDelegate, UIScrollViewDelegate {

    weak var delegete: FSRulerDelegate?
    var rulerScrollView: FSRulerScrollView?
    let DISTANCELEFTANDRIGHT :CGFloat = 8  //标尺左右距离
    let DISTANCEVALUE: CGFloat = 8 //刻度实际长度
    let DISTANCETOPANDBOTTOM: CGFloat = 20 //标尺上下距离
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.rulerScrollView = self.getRulerScrollView()
        self.rulerScrollView?.rulerHeight = NSInteger(frame.size.height)
        self.rulerScrollView?.rulerWidth = NSInteger(frame.size.width)
        
        
      //  self.rulerScrollView?.rulerWidth = CGFloat
     
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!;
        fatalError("init(coder:) has not been implemented")
    }
    /*
    *  count * average = 刻度最大值
    *  @param count        10个小刻度为一个大刻度，大刻度的数量
    *  @param average      每个小刻度的值，最小精度 0.1
    *  @param currentValue 直尺初始化的刻度值
    *  @param mode         是否最小模式
    */

    func showRulerScrollViewWithCount(_ count: NSInteger, average: NSNumber, currentValue: Float, smallMode: Bool) {
        
        self.rulerScrollView?.rulerAverage = average
        self.rulerScrollView?.rulerCount = count
        self.rulerScrollView?.rulerValue = currentValue
        self.rulerScrollView?.mode = smallMode
        self.rulerScrollView?.drawRuler()
        self.addSubview(self.rulerScrollView!)
        self.drawline()
        
        
        
    }
    
    func drawline() {
        let pathLine: CGMutablePath = CGMutablePath()
        let shapeLayerLine: CAShapeLayer = CAShapeLayer.init()
        shapeLayerLine.strokeColor = UIColor.red().cgColor
        shapeLayerLine.fillColor = UIColor.red().cgColor
        shapeLayerLine.lineWidth = 1.0
        shapeLayerLine.lineCap = kCALineCapSquare
        
        
        pathLine.moveTo(nil, x: self.frame.size.width / 2, y: self.frame.size.height - DISTANCETOPANDBOTTOM - 20)
        pathLine.addLineTo(nil, x: self.frame.size.width / 2, y: DISTANCETOPANDBOTTOM + 8)
        
        shapeLayerLine.path = pathLine
        self.layer.addSublayer(shapeLayerLine)
        
    }
    
    func getRulerScrollView() -> FSRulerScrollView {
        let scrollView: FSRulerScrollView = FSRulerScrollView(frame: CGRect.zero)
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }
    
    
//MARK: ScrollView Delegete
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollView: FSRulerScrollView = (scrollView as? FSRulerScrollView)!
        let offSetX = scrollView.contentOffset.x + self.frame.size.width / 2 - DISTANCELEFTANDRIGHT
        let rulerValue: Float = Float(offSetX / DISTANCEVALUE) * (scrollView.rulerAverage?.floatValue)!
        if rulerValue < 0 {
            return
        } else if (rulerValue > Float(scrollView.rulerCount!) * (scrollView.rulerAverage?.floatValue)!) {
            return
        }
        if ((self.delegete) != nil) {
            if ((scrollView.mode) != nil) {
                scrollView.rulerValue = rulerValue
            }
            scrollView.mode = false
            self.delegete?.fsRuler!(scrollView)
        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.animationRebound((scrollView as? FSRulerScrollView)!)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.animationRebound((scrollView as? FSRulerScrollView)!)
    }
    
    
    func animationRebound(_ scrollView: FSRulerScrollView) {
        let offSetX = scrollView.contentOffset.x + self.frame.size.width / 2 - DISTANCELEFTANDRIGHT
        var oX =  CGFloat(offSetX / DISTANCEVALUE) * CGFloat((scrollView.rulerAverage)!)
        
        if (self.valueIsInteger(number: scrollView.rulerAverage!)) {
            oX = self.notRounding(price: oX, afterPoint: 0)
        } else {
            oX = self.notRounding(price: oX, afterPoint: 1)
        }
        
        let offX = (oX / CGFloat((scrollView.rulerAverage?.floatValue)!)) * DISTANCEVALUE + DISTANCELEFTANDRIGHT - self.frame.size.width / 2
        UIView.animate(withDuration: 0.2) { () -> Void in
            scrollView.contentOffset = CGPoint(x: offX, y: 0)
        }
         scrollView.contentOffset = CGPoint(x: offX, y: 0)
    }
    
    
    
//MARK: ToolMethod
    func notRounding(price: CGFloat, afterPoint: NSInteger) -> CGFloat{
        let roundingBehavior: NSDecimalNumberHandler = NSDecimalNumberHandler.init(roundingMode: NSDecimalNumber.RoundingMode.roundPlain, scale: Int16(afterPoint), raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        let ouncesDecimal: NSDecimalNumber = NSDecimalNumber.init(value: Int(price))
        let roundedOunces: NSDecimalNumber = ouncesDecimal.rounding(accordingToBehavior: roundingBehavior)
        return CGFloat(roundedOunces.floatValue)
        
    }
    
    
    func valueIsInteger(number: NSNumber) -> Bool {
        let value: NSString =  String(format: "%f",number.floatValue)
        if value.length > 0 {
            let stringArray: NSArray = value.components(separatedBy: ".")
            let valueEnd: NSString = stringArray.object(at: 1) as! NSString
            var temp: String
            let count: NSInteger = valueEnd.length
            
            for index in 0...count {
                temp = valueEnd.substring(with: NSRange.init(location: index, length: 1))
                if temp == "0" {
                    return false
                }
            }
        }
        
        return true
    }
    
    
}
