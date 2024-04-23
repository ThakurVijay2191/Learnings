//
//  ExploreViewModel.swift
//  TourApp
//
//  Created by Nap Works on 18/04/24.
//

import SwiftUI

class ExploreViewModel: ObservableObject {
    @Published var cards: [CardDataModel] = []
    @Published var showIndicator: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    init() {
        getCards()
    }
    func getCards(){
        self.showIndicator = true
        WebServiceManager.getData { error, list in
            self.showIndicator = false
            if let error {
                self.showAlert = true
                self.alertMessage = error.localizedDescription
            }else {
                DispatchQueue.main.async {
                    self.cards = list
                }
            }
        }
    }
}
