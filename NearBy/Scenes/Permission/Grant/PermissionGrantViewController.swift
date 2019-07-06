//
//  PermissionGrantViewController.swift
//  NearBy
//
//  Created by Ahmet Gülden on 6.07.2019.
//  Copyright © 2019 Ahmet Gülden. All rights reserved.
//

import UIKit

private enum Constants {
    static let descriptionLabelTopPadding: CGFloat = 20.0
    static let iconViewHorizontalProportionalRatio: CGFloat = 0.5
}

final class PermissionGrantViewController: ViewController {

    var viewModel: PermissionGrantViewModel!
    var router: PermissionGrantRouter!

    private let descriptionLabel = UILabel()
    private let iconView = UIImageView(frame: .zero)
    private let rejectButton = UIButton(type: .system)
    private let approveButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()

        handleStateChange()
        applyStyling()
        configureDescriptionText()
        configureIcon()
        configureActionButtons()
    }
}

// MARK: - State Handling

private extension PermissionGrantViewController {

    func handleStateChange() {
        viewModel.setStateChangeHandler { [weak self] _ in
            guard let strongSelf = self else {
                return
            }

            strongSelf.router.permissionGrantProcessFinished(context: strongSelf)
        }
    }
}

// MARK: - Configuration

private extension PermissionGrantViewController {

    func applyStyling() {
        view.backgroundColor = UIColor.nrb_backgroundColor
    }

    func configureDescriptionText() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text = viewModel.permission.descriptionText
        // TODO set styling to description label
        view.addSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                      constant: Global.UI.margin),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                       constant: -Global.UI.margin),
            descriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                 constant: Constants.descriptionLabelTopPadding)
            ])
    }

    func configureIcon() {
        iconView.image = viewModel.permission.icon
        iconView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(iconView)

        NSLayoutConstraint.activate([
            iconView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor,
                                          constant: Global.UI.margin),
            iconView.widthAnchor.constraint(equalTo: iconView.heightAnchor, multiplier: 1.0),
            iconView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
            ])

        let proportionalConstraint = iconView.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: Constants.iconViewHorizontalProportionalRatio)
        proportionalConstraint.priority = UILayoutPriority.defaultHigh
        proportionalConstraint.isActive = true
    }

    func configureActionButtons() {
        rejectButton.translatesAutoresizingMaskIntoConstraints = false
        rejectButton.nrb_applyStyle(.secondary, title: viewModel.permission.rejectText)
        rejectButton.addTarget(self, action: #selector(userRejected), for: .touchUpInside)
        view.addSubview(rejectButton)
        NSLayoutConstraint.activate([
            rejectButton.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            rejectButton.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            rejectButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                 constant: -Global.UI.margin),
            rejectButton.heightAnchor.constraint(equalToConstant: Global.UI.buttonHeight)
            ])

        approveButton.translatesAutoresizingMaskIntoConstraints = false
        approveButton.nrb_applyStyle(.primary, title: viewModel.permission.approveText)
        approveButton.addTarget(self, action: #selector(userApproved), for: .touchUpInside)
        view.addSubview(approveButton)
        NSLayoutConstraint.activate([
            approveButton.leadingAnchor.constraint(equalTo: rejectButton.leadingAnchor),
            approveButton.trailingAnchor.constraint(equalTo: rejectButton.trailingAnchor),
            approveButton.bottomAnchor.constraint(equalTo: rejectButton.topAnchor,
                                                  constant: -Global.UI.margin),
            approveButton.topAnchor.constraint(greaterThanOrEqualTo: iconView.bottomAnchor,
                                               constant: Global.UI.margin),
            approveButton.heightAnchor.constraint(equalToConstant: Global.UI.buttonHeight)
            ])
    }
}

// MARK: - Actions

private extension PermissionGrantViewController {

    @objc
    func userApproved() {
        viewModel.approve()
    }

    @objc
    func userRejected() {
        viewModel.reject()
    }
}
