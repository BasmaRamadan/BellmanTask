//
//  MainModel.swift
//  Task
//
//  Created by Basma on 12/13/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import Foundation
import SwiftyJSON
class ListItemModel : NSObject{
    var name : String?
    var descrip : String?
    var photos : [String]?
    
    override init() {
    }
    
    init(parametersJson: [String: JSON])
    {
        
        if let name = parametersJson["name"]?.stringValue
        {
            self.name = name
        }
        
        if let descrip = parametersJson["description"]?.string
        {
            self.descrip = descrip
        }
        
        if let photos = parametersJson["photos"]?.array
        {
            var photoList = [String]()
            for item in photos {
                photoList.append(item.stringValue)
            }
            self.photos = photoList
        }
        
    }
}
