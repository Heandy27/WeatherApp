//
//  Weather5DaysView.swift
//  WeatherApp
//
//  Created by Andy Heredia on 1/1/25.
//

import SwiftUI

struct Weather5DaysView: View {
    
    let weatherData: ListResponse
    @StateObject var viewModel = Weather5DaysViewModel()
    
    var body: some View {
        VStack(spacing: 5) {
            Text(viewModel.formatDate(weatherData.dt_txt))
                .font(.system(size: 20))
            Image(systemName: viewModel.idStringIcon(weatherData.weather.first?.id ?? 0))
                .font(.system(size: 25))
            Text(weatherData.weather.first?.main ?? "")
                .font(.system(size: 18))
            Text(viewModel.tempString(weatherData.main.temp))
                .font(.system(size: 20))
        }
        .padding()
        .foregroundStyle(.white)
        .frame(maxWidth: 350, maxHeight: 350)
        .background(LinearGradient(gradient: Gradient(colors: [
            Color(red: 168/255, green: 154/255, blue: 225/255),
            Color(red: 118/255, green: 96/255, blue: 244/255)
        ]),
                                   startPoint: .topLeading,
                                   endPoint: .bottomLeading))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 2)
    }
}

#Preview {
    Weather5DaysView(weatherData: ListResponse(dt: 1, main: Main(temp: 17.15), weather: [WeatherResponse(id: 1, main: "Rain")], dt_txt: "2025-01-03 03:00:00"))
}
