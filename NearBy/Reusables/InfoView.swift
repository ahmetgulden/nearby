//
//  InfoView.swift
//  NearBy
//
//  Created by Ahmet Gülden on 6.07.2019.
//  Copyright © 2019 Ahmet Gülden. All rights reserved.
//

import UIKit

/// Generic information view for showing messages.
final class InfoView: UIView {

    /// Label of info view.
    let infoLabel = UILabel()
    private var infoLabelVerticalConstraint: NSLayoutConstraint?

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureInfoView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InfoView {

    /// Creates and shows an info view inside view controller.
    ///
    /// - Parameters:
    ///   - message: Message to be displayed in info view.
    ///   - viewController: View controller in which info view will be displayed.
    @discardableResult
    class func show(message: String, in viewController: UIViewController) -> InfoView {
        let infoView = InfoView()
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.backgroundColor = UIColor.nrb_backgroundColor.withAlphaComponent(0.7)
        viewController.view.addSubview(infoView)

        infoView.infoLabel.text = message

        NSLayoutConstraint.activate([
            infoView.leadingAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.leadingAnchor),
            infoView.trailingAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.trailingAnchor),
            ])

        let infoViewVerticalConstraint = infoView.bottomAnchor.constraint(
            equalTo: viewController.view.safeAreaLayoutGuide.topAnchor)
        infoViewVerticalConstraint.isActive = true
        viewController.view.layoutIfNeeded()

        UIView.animate(withDuration: Global.UI.animationDuration) {
            infoView.infoLabelVerticalConstraint?.isActive = false
            infoViewVerticalConstraint.isActive = false

            NSLayoutConstraint.activate([
                infoView.topAnchor.constraint(equalTo: viewController.view.topAnchor),
                infoView.infoLabel.topAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.topAnchor,
                                                        constant: Global.UI.margin)
                ])
            viewController.view.layoutIfNeeded()
        }

        return infoView
    }
}

private extension InfoView {

    func configureInfoView() {
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.textColor = UIColor.nrb_oceanBlueColor
        infoLabel.numberOfLines = 0
        addSubview(infoLabel)

        NSLayoutConstraint.activate([
            infoLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                               constant: Global.UI.margin),
            infoLabel.bottomAnchor.constraint(equalTo: bottomAnchor,
                                              constant: -Global.UI.margin),
            infoLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                constant: -Global.UI.margin),
            ])

        infoLabelVerticalConstraint = infoLabel.topAnchor.constraint(
            equalTo: topAnchor,
            constant: Global.UI.margin)
        infoLabelVerticalConstraint?.isActive = true
    }
}
