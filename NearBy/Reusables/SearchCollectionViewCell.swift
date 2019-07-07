//
//  SearchCollectionViewCell.swift
//  NearBy
//
//  Created by Ahmet Gülden on 8.07.2019.
//  Copyright © 2019 Ahmet Gülden. All rights reserved.
//

import UIKit

private enum Constants {
    static let cellHorizontalInset: CGFloat = 8.0
}

final class SearchCollectionViewCell: UICollectionViewCell {

    @IBOutlet private(set) weak var titleLabel: UILabel!

    override func preferredLayoutAttributesFitting(
        _ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {

        setNeedsLayout()
        layoutIfNeeded()

        var frame = layoutAttributes.frame
        let maxSize = CGSize(width: .greatestFiniteMagnitude, height: frame.height)
        let size = titleLabel.sizeThatFits(maxSize)
        frame.size.width = ceil(size.width) + Constants.cellHorizontalInset
        layoutAttributes.frame = frame
        return layoutAttributes
    }
}
