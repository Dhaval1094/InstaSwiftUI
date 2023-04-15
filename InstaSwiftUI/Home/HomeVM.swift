//
//  HomeVM.swift
//  InstaSwiftUI
//
//  Created by Gwl on 15/04/23.
//

import Foundation

class HomeVM: ObservableObject {
    @Published var searchResponse: SearchResponse?
    @Published var photos: [Photo] = []
    func getSearchList() {
        APIClient.shared.callSearch { searchResponse, error in
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
            self.photos = photos
        }
    }
}
