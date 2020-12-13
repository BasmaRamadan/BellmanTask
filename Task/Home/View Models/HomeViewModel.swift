//
//  HomeViewModel.swift
//  Task
//
//  Created by Basma on 12/13/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import Foundation
enum State {
    case loading
    case loaded
    case empty
    case error
}
class HomeViewModel {
    let apiService = APIService()
    //    private var homeData: MainModel = MainModel()
    
    var reloadTableViewClosure: (()->())?
    var reloadHotspotCollectionViewClosure: (()->())?
    var reloadEventsCollectionViewClosure: (()->())?
    var reloadAttractionsCollectionViewClosure: (()->())?
    
    var updateLoadingStatus: (()->())?
    var hotspotViewModels = [ItemCellViewModel]()
    var eventsViewModels = [ItemCellViewModel]()
    var attractionsViewModels = [ItemCellViewModel](){
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    private var mainCellViewModel: MainCellViewModel = MainCellViewModel(hot_spots: [ItemCellViewModel](), events: [ItemCellViewModel](), attractions: [ItemCellViewModel]()) {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    var state: State = .empty {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    func getData() {
        state = .loading
        let url = APIConstants().homeURL()
        apiService.getRequest(url: url, method: .get, parameters: nil, completion: {(error, response) in
            if response != nil{
                let mainData = MainModel(parametersJson: response!["data"].dictionaryValue)
                self.createCellsViewModels(homeData: mainData)
                self.state = .loaded
            }else {
                self.state = .error
                print(error)
            }
            
        })
    }
    
    func getHotspotCellViewModel() -> [ItemCellViewModel] {
        return hotspotViewModels
    }
    
    func getEventsCellViewModel() -> [ItemCellViewModel] {
        return eventsViewModels
    }
    
    func getAttractionsCellViewModel() -> [ItemCellViewModel] {
        return attractionsViewModels
    }
    
    private func createCellsViewModels(homeData: MainModel) {
        
        var hotspotViewModels = [ItemCellViewModel]()
        if let hotspots = homeData.hot_spots{
            for item in hotspots {
                hotspotViewModels.append(createCellViewModel(itemModel: item))
            }
        }
        self.hotspotViewModels = hotspotViewModels
        
        var eventsViewModels = [ItemCellViewModel]()
        if let events = homeData.events {
            for item in events {
                eventsViewModels.append(createCellViewModel(itemModel: item))
            }
        }
        self.eventsViewModels = eventsViewModels
        
        var attractionsViewModels = [ItemCellViewModel]()
        if let attractions = homeData.attractions {
            for item in attractions {
                attractionsViewModels.append(createCellViewModel(itemModel: item))
            }
        }
        self.attractionsViewModels = attractionsViewModels
    }
    private func createCellViewModel(itemModel: ListItemModel) -> ItemCellViewModel {
        return ItemCellViewModel(name: itemModel.name ?? "", description: itemModel.descrip ?? "", photos: itemModel.photos ?? [String]())
    }
}
