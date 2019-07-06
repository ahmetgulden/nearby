//
//  UIButton+Styling.swift
//  NearBy
//
//  Created by Ahmet Gülden on 6.07.2019.
//  Copyright © 2019 Ahmet Gülden. All rights reserved.
//

import UIKit

extension UIButton {

    /// Styles of ui buttons in application.
    ///
    /// - primary: Primary style of ui button.
    /// - secondary: Secondary style of ui button.
    enum Style {
        case primary
        case secondary

        fileprivate var cornerRadius: CGFloat {
            switch self {
            case .primary:
                return 5.0
            case .secondary:
                return 0.0
            }
        }

        fileprivate var titleColor: UIColor {
            switch self {
            case .primary:
                return UIColor.white
            case .secondary:
                return UIColor.gray
            }
        }

        fileprivate var backgroundColor: UIColor {
            switch self {
            case .primary:
                return UIColor.blue
            case .secondary:
                return UIColor.clear
            }
        }

        fileprivate var font: UIFont {
            switch self {
            case .primary:
                return UIFont.systemFont(ofSize: 14.0)
            case .secondary:
                return UIFont.systemFont(ofSize: 13.0)
            }
        }
    }

    /// Applies given button style to ui button with assigning title.
    ///
    /// - Parameters:
    ///   - style: Style of the button.
    ///   - title: Title of the button.
    func nrb_applyStyle(_ style: Style, title: String = "") {
        setTitle(title, for: .normal)
        layer.cornerRadius = style.cornerRadius
        setTitleColor(style.titleColor, for: .normal)
        titleLabel?.font = style.font
        backgroundColor = style.backgroundColor
    }
}
