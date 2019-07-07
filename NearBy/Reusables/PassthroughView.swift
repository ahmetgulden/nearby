//
//  PassthroughView.swift
//  NearBy
//
//  Created by Ahmet Gülden on 8.07.2019.
//  Copyright © 2019 Ahmet Gülden. All rights reserved.
//

import UIKit

final class PassthroughView: UIView {

    private var hittableSubviews: Set<UIView> = []

    func addHittableSubview(_ view: UIView) {
        hittableSubviews.formUnion([view])
    }

    func isViewHittable(_ view: UIView?) -> Bool {
        guard let view = view else {
            return false
        }
        return hittableSubviews.contains { hittableSubview -> Bool in
            if hittableSubview == view {
                return true
            }
            return isViewHittable(view.superview)
        }
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        guard isViewHittable(view) else {
            return nil
        }
        return view
    }
}
