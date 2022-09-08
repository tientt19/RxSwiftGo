//
//  Task.swift
//  GoodList
//
//  Created by Tiến Trần on 08/09/2022.
//  Copyright © 2022 Mohammad Azam. All rights reserved.
//

import Foundation

enum Priority: Int {
    case high
    case medium
    case low
}


struct Task {
    let title: String
    let priority: Priority
}
