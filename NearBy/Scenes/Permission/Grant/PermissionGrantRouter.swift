//
//  PermissionGrantRouter.swift
//  NearBy
//
//  Created by Ahmet Gülden on 6.07.2019.
//  Copyright © 2019 Ahmet Gülden. All rights reserved.
//

import UIKit

/// Router for permission grant view controller.
final class PermissionGrantRouter {

    /// Routes to finish for granting permission process.
    ///
    /// - Parameter context: UI view controller context.
    func permissionGrantProcessFinished(context: UIViewController) {
        context.dismiss(animated: true, completion: nil)
    }
}
