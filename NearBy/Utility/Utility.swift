//
//  Utility.swift
//  NearBy
//
//  Created by Ahmet Gülden on 6.07.2019.
//  Copyright © 2019 Ahmet Gülden. All rights reserved.
//

import CoreData
import UIKit

enum Utility {

    /// Returns application display name.
    ///
    /// - Returns: Application display name.
    static func getAppName() -> String {
        return (Bundle.main.object(forInfoDictionaryKey: kCFBundleNameKey as String) as? String) ?? ""
    }

    /// Opens settings application and navigates to the part regarding this applicaiton.
    static func openSettingsApplication() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

    static func context() -> NSManagedObjectContext {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Unable to retrieve managed object context")
        }
        return appDelegate.persistentContainer.viewContext
    }
}
