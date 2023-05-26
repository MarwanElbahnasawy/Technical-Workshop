//
//  UIImageGradient.swift
//  Technical-Workshop
//
//  Created by moamen ali gomaa on 26/05/2023.
//

import UIKit

extension UIImageView {
    //MARK:- gradient backgroung
    func makeGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.contents = self.image?.cgImage
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        self.layer.addSublayer(gradient)
    }
}
