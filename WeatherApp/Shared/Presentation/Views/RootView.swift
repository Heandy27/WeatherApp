//
//  RootView.swift
//  WeatherApp
//
//  Created by Andy Heredia on 2/1/25.
//

import SwiftUI

struct RootView: View {
    
    @Environment(AppStateVM.self) var appState
    
    var body: some View {
        switch (appState.status) {
        case .errorApp:
            ErrorView()
        case .loading:
            LoadingView()
        case .success:
            WeatherHomeView(viewModel: WeatherHomeViewModel())
        }
    }
}

#Preview {
    RootView()
        .environment(AppStateVM())
}
