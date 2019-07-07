//
//  SearchViewController.swift
//  NearBy
//
//  Created by Ahmet Gülden on 7.07.2019.
//  Copyright © 2019 Ahmet Gülden. All rights reserved.
//

import UIKit

private enum Constants {
    static let cellEstimatedSize: CGSize = CGSize(width: 100.0, height: 40.0)
}

private enum SearchViewState {
    case expanded
    case collapsed
}

final class SearchViewController: ViewController {

    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var openButton: UIButton!
    @IBOutlet private weak var openButtonIconView: UIView!

    @IBOutlet private(set) weak var contentView: UIView!

    @IBOutlet private weak var searchView: UIView!
    @IBOutlet private weak var searchTitleLabel: UILabel!
    @IBOutlet private weak var searchTextField: UITextField!

    @IBOutlet private weak var exploreView: UIView!
    @IBOutlet private weak var exploreTitleLabel: UILabel!
    @IBOutlet private weak var exploreCollectionView: UICollectionView!

    @IBOutlet private weak var expandedLayoutConstraint: NSLayoutConstraint!
    @IBOutlet private weak var collapsedLayoutConstraint: NSLayoutConstraint!

    private let presentation = SearchViewPresentation()
    weak var mapViewModel: MapViewModel?

    private var state: SearchViewState = .collapsed {
        didSet {
            guard state != oldValue else {
                return
            }
            updateViewState()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUIElements()
        updateViewState(animated: false)
    }
}

// MARK: - Configuration

private extension SearchViewController {

    func configureUIElements() {
        contentView.layer.cornerRadius = 15.0
        closeButton.setTitle(presentation.closeButtonText, for: .normal)
        searchTitleLabel.text = presentation.searchTitleText

        // TODO add text field close toolbar button.

        searchTextField.placeholder = presentation.searchTextPlaceholder
        searchTextField.returnKeyType = .search
        searchTextField.delegate = self
        exploreTitleLabel.text = presentation.exploreTitleText
        exploreCollectionView.dataSource = self
        exploreCollectionView.delegate = self
        let layout = exploreCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.itemSize = UICollectionViewFlowLayout.automaticSize
        layout?.estimatedItemSize = Constants.cellEstimatedSize
    }
}

// MARK: - UICollectionViewDataSource

extension SearchViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HereAPI.Category.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: SearchCollectionViewCell.self),
            for: indexPath) as? SearchCollectionViewCell else {
                return UICollectionViewCell()
        }
        cell.titleLabel.text = HereAPI.Category.allCases[indexPath.row].rawValue
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension SearchViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {

        state = .collapsed
        mapViewModel?.explore(category: HereAPI.Category.allCases[indexPath.row])
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension SearchViewController: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        state = .expanded
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        state = .collapsed
        mapViewModel?.search(text: textField.text ?? "")
        return true
    }
}

// MARK: - Actions

private extension SearchViewController {

    @IBAction func openButtonTapped() {
        state = .expanded
    }

    @IBAction func closeButtonTapped() {
        state = .collapsed
    }
}

// MARK: - View State Change

private extension SearchViewController {

    func updateViewState(animated: Bool = true) {
        view.layoutIfNeeded()
        if state == .collapsed {
            searchTextField.resignFirstResponder()
        }
        UIView.animate(withDuration: animated ? Global.UI.animationDuration : 0.0) {
            let isCollapsed = self.state == SearchViewState.collapsed
            self.closeButton.alpha = isCollapsed ? 0.0 : 1.0
            self.openButton.alpha = isCollapsed ? 1.0 : 0.0
            self.openButtonIconView.alpha = isCollapsed ? 1.0 : 0.0
            self.exploreView.alpha = isCollapsed ? 0.0 : 1.0
            self.expandedLayoutConstraint.priority = isCollapsed ? UILayoutPriority.defaultLow : UILayoutPriority.defaultHigh
            self.collapsedLayoutConstraint.priority = isCollapsed ? UILayoutPriority.defaultHigh : UILayoutPriority.defaultLow
            self.view.layoutIfNeeded()
        }
    }
}
