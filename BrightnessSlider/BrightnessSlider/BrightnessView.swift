//
//  BrightnessView.swift
//  BrightnessSlider
//
//  Created by Всеволод on 29.05.2023.
//

import UIKit


final class CustomSlider: UIControl {
    var value: CGFloat = 0.8 {
        didSet {
            setNeedsDisplay()
//            UIScreen.main.brightness = brightness
            sendActions(for: .valueChanged)
        }
    }
    
    var lastTouchY: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .clear
//        UIScreen.main.brightness = brightness
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        let cornerRadius: CGFloat = 36
        let backgroundColor = UIColor.black.withAlphaComponent(0.6)
        let valueColor = UIColor.white
        
        let backgroundPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        backgroundPath.addClip()
        
        backgroundColor.setFill()
        backgroundPath.fill()
        
        guard value > 0 else {
            return
        }
        
        let valueRect = CGRect(x: 0, y: rect.height * (1 - value), width: rect.width, height: rect.height * value)
        let valuePath = UIBezierPath(rect: valueRect)
        
        valueColor.setFill()
        valuePath.fill()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            let position = touch.location(in: self)
            
            lastTouchY = position.y
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            let position = touch.location(in: self)
            
            guard value <= 1 && value >= 0 else {
                return
            }
            
            if position.y < lastTouchY && value < 1 {
                value = min(value + (lastTouchY - position.y) / (2 * self.bounds.height), 1)
            } else if position.y > lastTouchY && value > 0 {
                value = max(value - (position.y - lastTouchY) / (2 * self.bounds.height), 0)
            }
            
            lastTouchY = position.y
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let outsideArea = CGSize(width: 44, height: 44)
        
        let newX = bounds.origin.x - outsideArea.width / 2
        let newY = bounds.origin.y - outsideArea.height / 2
        
        let newArea = CGRect(x: newX, y: newY, width: bounds.width + outsideArea.width, height: bounds.height + outsideArea.height)
        
        return newArea.contains(point)
    }
}
