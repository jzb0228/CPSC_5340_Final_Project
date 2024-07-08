//
//  AuthView.swift
//  Final Project
//
//  Created by Justin Baik on 7/7/24.
//

import SwiftUI

struct AuthView: View {
    @State private var currentViewShowing: String = "login"
    var body: some View {
        if(currentViewShowing == "login") {
            LoginView(currentShowingView: $currentViewShowing)
        } else {
            SignupView(currentShowingView: $currentViewShowing)
                .transition(.move(edge: .bottom))
        }
    }
}

#Preview {
    AuthView()
}
