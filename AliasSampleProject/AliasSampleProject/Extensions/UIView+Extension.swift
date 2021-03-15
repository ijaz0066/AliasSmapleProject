//
//  UIView+Extension.swift
//  AliasSampleProject
//
//  Created by ijaz ahmad on 2021-03-14.
//

import Foundation
import UIKit

extension UIView {
    
    func roundCorners() {
        self.layer.cornerRadius = self.frame.height/2
    }
}
