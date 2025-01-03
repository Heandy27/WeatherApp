//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Andy Heredia on 25/12/24.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    
    var appState = AppStateVM()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(AppStateVM())
        }
    }
}
