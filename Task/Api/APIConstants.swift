//
//  APIConstants.swift
//  Task
//
//  Created by Basma on 12/13/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import Foundation
class APIConstants {
    static let baseURL = "http://bellman-bd.restart-technology.com/api/"
    
    func homeURL () -> String {
        return "\(APIConstants.baseURL)home"
    }
}
