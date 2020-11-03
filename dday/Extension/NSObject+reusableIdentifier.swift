//
//  NSObject+reusableIdentifier.swift
//  dday
//
//  Created by jinhyuk on 2020/11/02.
//  Copyright © 2020 jinhyuk. All rights reserved.
//

import Foundation

extension NSObject {
    static var reusableIdentifier: String {
        return String(describing: self)
    }
}
