//
//  ContentView.swift
//  WeatherApp
//
//  Created by Andy Heredia on 25/12/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
//        .onAppear {
//            Task {
//               try await NetworkWeather().getWeather(city: "quito")
//            }
//        }
    }
}

#Preview {
    ContentView()
}
