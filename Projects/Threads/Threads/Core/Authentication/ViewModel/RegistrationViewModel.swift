//
//  RegistrationViewModel.swift
//  Threads
//
//  Created by Nap Works on 02/10/23.
//

import SwiftUI

class RegistrationViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var fullname: String = ""
    @Published var username: String = ""
    
    @MainActor
    func createUser() async throws {
        try await AuthService.shared.createUser(withEmail: email, password: password, fullName: fullname, username: username)
    }
}
