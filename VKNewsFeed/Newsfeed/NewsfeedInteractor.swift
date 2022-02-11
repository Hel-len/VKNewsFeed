//
//  NewsfeedInteractor.swift
//  VKNewsFeed
//
//  Created by Елена Дранкина on 24.01.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsfeedBusinessLogic {
    func makeRequest(request: Newsfeed.Model.Request.RequestType)
}

final class NewsfeedInteractor: NewsfeedBusinessLogic {
    
    var presenter: NewsfeedPresentationLogic?

    private var fetcher: DataFetcher = NetworkDataFetcher()
    
    func makeRequest(request: Newsfeed.Model.Request.RequestType) {
        switch request {
            
        case .getNewsfeed:
            fetcher.getFeed(for: .vkApiSettings){ [weak self] (feedResponse) in
                guard let feedResponse = feedResponse else { return }
                self?.presenter?.presentData(response: .presentNewsfeed(feed: feedResponse))
            }
        }
    }
}
