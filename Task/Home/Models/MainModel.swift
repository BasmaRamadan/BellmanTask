//
//  MainModel.swift
//  Task
//
//  Created by Basma on 12/13/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import Foundation
import SwiftyJSON
class MainModel : NSObject{
    var hot_spots : [ListItemModel]?
    var events : [ListItemModel]?
    var attractions : [ListItemModel]?
    
    override init() {
    }
    
    init(parametersJson: [String: JSON])
    {
        
        
        if let hot_spots = parametersJson["hot_spots"]?.array
        {
            var hot_spotsList = [ListItemModel]()
            for item in hot_spots {
                hot_spotsList.append(ListItemModel(parametersJson: item.dictionaryValue))
            }
            self.hot_spots = hot_spotsList
        }
        
        if let events = parametersJson["events"]?.array
        {
            var eventsList = [ListItemModel]()
            for item in events {
                eventsList.append(ListItemModel(parametersJson: item.dictionaryValue))
            }
            self.events = eventsList
        }
        
        if let attractions = parametersJson["attractions"]?.array
        {
            var attractionsList = [ListItemModel]()
            for item in attractions {
                attractionsList.append(ListItemModel(parametersJson: item.dictionaryValue))
            }
            self.attractions = attractionsList
        }
        
        
    }
}
