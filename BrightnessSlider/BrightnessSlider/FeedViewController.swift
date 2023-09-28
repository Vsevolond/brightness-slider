//
//  FeedViewController.swift
//  BrightnessSlider
//
//  Created by Всеволод on 29.05.2023.
//

import UIKit


final class FeedViewController: UIViewController {
    private let backGroundImageView = UIImageView()
    private let iconImageView = UIImageView()
    private let slider = CustomSlider()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupIcon()
        setupSlider()
        setupBackground()
        
        view.addSubview(backGroundImageView)
        view.addSubview(iconImageView)
        view.addSubview(slider)
    }
    
    private func setupIcon() {
        let width: CGFloat = 50, height: CGFloat = 50
        
        iconImageView.image = UIImage(systemName: "sun.min.fill")
        iconImageView.tintColor = .white
        iconImageView.frame = CGRect(x: view.center.x - width / 2, y: 200, width: width, height: height)
    }
    
    private func setupSlider() {
        let width = view.frame.width / 3
        let height = view.frame.height / 3

        slider.frame = .init(x: view.center.x - width / 2, y: view.center.y - height / 2, width: width, height: height)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        
        UIScreen.main.brightness = slider.value
    }
    
    private func setupBackground() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        backGroundImageView.image = UIImage(named: "screenshot")
        backGroundImageView.contentMode = .scaleToFill
        
        backGroundImageView.frame = view.frame
        blurEffectView.frame = backGroundImageView.bounds
        
        backGroundImageView.addSubview(blurEffectView)
    }
    
    @objc private func sliderValueChanged() {
        UIScreen.main.brightness = slider.value
        
        if slider.value == 1 {
            animateIcon()
        }
    }
    
    private func animateIcon() {
        UIView.animate(withDuration: 0.2, delay: 0.0, animations: {
            self.iconImageView.transform = CGAffineTransform(scaleX: 88 / 72, y: 88 / 72)
        }, completion: { _ in
            UIView.transition(with: self.iconImageView, duration: 0.2, options: .curveEaseIn, animations: {
                self.iconImageView.image = UIImage(systemName: "sun.max.fill")
                self.iconImageView.transform = .identity
            }, completion: nil)
        })
        
//        UIView.transition(with: iconImageView, duration: 0.2) {
//            self.iconImageView.image = UIImage(systemName: "sun.max.fill")
//        }
    }
}
