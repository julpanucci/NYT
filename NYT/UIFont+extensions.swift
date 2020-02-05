//
//  UIFont+extensions.swift
//  NYT
//
//  Created by Julian Panucci on 2/5/20.
//  Copyright © 2020 Panucci. All rights reserved.
//

import UIKit


extension UIFont {

    public enum `Type`: String {
        case semibold = "-SemiBold"
        case regular = "-Regular"
        case light = "-Light"
        case extraBold = "-ExtraBold"
        case bold = "-Bold"
    }

    public enum CustomFont: String {
        case chomsky = "Chomsky"
    }

    static func customFont(_ font: CustomFont, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        if let font = UIFont(name: "\(font.rawValue)", size: size) {
            return font
        } else {
            print("\nCould not find font. Make sure it is added to your Info.plist!\n")
            return UIFont.systemFont(ofSize: size)
        }
    }

}
