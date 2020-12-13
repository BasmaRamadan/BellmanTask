//
//  ApiService.swift
//  Task
//
//  Created by Basma on 12/13/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class APIService {
    typealias ApiResponse = (Error?, JSON?) -> Void

    func getRequest(url : String,method: HTTPMethod, parameters: [String: Any]?, completion:@escaping ApiResponse) {
      Alamofire.request(url, method: method).validate().responseJSON { response in
        if let result = response.result.value
        {
            completion(nil, JSON(result));
        }
        else
        {
            completion(response.result.error, nil);
        }
      }
    }
}
