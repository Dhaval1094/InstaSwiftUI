//
//  HomeVM.swift
//  InstaSwiftUI
//
//  Created by Dhaval Trivedi on 15/04/23.
//

import Foundation
import SwiftUI

class HomeVM: ObservableObject {
    @Published var searchResponse: SearchResponse?
    @Published var photos: [Photo] = []
    var lastPage = 0
    func getSearchList(page: Int = 1, perPage: Int = 40) {
        APIClient.shared.callSearch (
            page: page,
            perPage: perPage
        ) { searchResponse, error in
            self.lastPage = page
            guard error == nil else {
                return
            }
            guard let response = searchResponse else {
                return
            }
            self.searchResponse = response
            guard let photos = response.photos else {
                return
            }
            self.photos.append(contentsOf: photos)
        }
    }
    func reset() {
        lastPage = 1
        searchResponse = nil
        photos.removeAll()
    }
    func loadMore() {
        lastPage += 1
        getSearchList(page: lastPage)
    }
    func isLast(item: Photo) -> Bool {
        guard let lastPhotoId = photos.last?.id,
              let itemId = item.id else {
            return false
        }
        return lastPhotoId == itemId
    }
    func searchAction(text: String = "") {
        APIClient.shared.searchString = text
        reset()
        getSearchList()
    }
    func refresh() {
        searchAction()
    }
    func columns(count: Int) -> [GridItem] {
        var grids = [GridItem]()
        for _ in 0...count - 1 {
            grids.append(GridItem(spacing: 0))
        }
        return grids
    }
}
