//
//  ContentViewModel.swift
//  Threads
//
//  Created by Nap Works on 02/10/23.
//

import Combine
import Firebase

class ContentViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    private var cancellables = Set<AnyCancellable>()
    
    
    init(){
        setupSusbscribers()
    }
    
    private func setupSusbscribers(){
        AuthService.shared.$userSession.sink { [weak self] userSession in
            self?.userSession = userSession
        }.store(in: &cancellables)
    }
}
