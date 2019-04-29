//
//  UITableViewRegistration.swift
//  cityEvents
//
//  Created by Aleksandr Kandalov on 12/4/18.
//  Copyright © 2018 Aleksandr Kandalov. All rights reserved.
//

import UIKit

public extension UITableView {
    static var associatedKey: NSString = "kTableViewRegistrationAssociatedKey"
    var setOfRegisteredClasses: NSMutableSet {
        var set = objc_getAssociatedObject(self, &UITableView.associatedKey) as? NSMutableSet
        if set == nil {
            set = NSMutableSet()
            objc_setAssociatedObject(self, &UITableView.associatedKey, set, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        return set!
    }
    
    private func register(_ mClass: AnyClass) {
        let name = NSStringFromClass(mClass)
        if !setOfRegisteredClasses.contains(name) {
            setOfRegisteredClasses.add(name)
            self.register(mClass, forCellReuseIdentifier: name)
        }
    }
    
    func dequeueReusableCell<T: UITableViewCell>(withClass mClass: T.Type, for indexPath: IndexPath) -> T {
        register(mClass)
        return (self.dequeueReusableCell(withIdentifier: NSStringFromClass(mClass), for: indexPath) as? T)!
    }
    
    private func registerHeaderFooterViewClass(_ mClass: AnyClass) {
        let name = String(format: "HeaderFooter:%@", NSStringFromClass(mClass))
        if !setOfRegisteredClasses.contains(name) {
            setOfRegisteredClasses.add(name)
            self.register(mClass, forHeaderFooterViewReuseIdentifier: name)
        }
    }
    
    func dequeueReusableHeaderFooterView(withClass mClass: AnyClass) -> UITableViewHeaderFooterView? {
        registerHeaderFooterViewClass(mClass)
        return self.dequeueReusableHeaderFooterView(withIdentifier: String(format: "HeaderFooter:%@", NSStringFromClass(mClass)))
    }
}
