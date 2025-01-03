//
//  WeatherHomeView.swift
//  WeatherApp
//
//  Created by Andy Heredia on 25/12/24.
//

import SwiftUI

struct WeatherHomeView: View {
    
    @StateObject var viewModel: WeatherHomeViewModel
  //  @StateObject var locationManager = LocationManager()
    @StateObject var locationViewModel = LocationViewModel()
    @StateObject var weather5DaysViewModel = Weather5DaysViewModel()
    
    let gridItem = [
        GridItem(.flexible())
    ]
    
    
    var body: some View {
        
     
            NavigationView {
                VStack {
                    // First Section searchbar and location
                    HStack {
                        
                        TextField("", text: $viewModel.cityText, prompt:Text("Search...").foregroundStyle(Color(.gray).opacity(0.4)))
                            .padding(.leading, 32)
                            .padding(.vertical, 10)
                            .onSubmit {
                                Task {
                                    await viewModel.getWeather()
                                    await weather5DaysViewModel.getWeather5Days(lat: viewModel.weatherResult.coord.lat, lon: viewModel.weatherResult.coord.lon)
                                    
                                }
                            }
                        
                        
                            .overlay(
                                RoundedRectangle(cornerRadius: 10) // Borde
                                    .stroke(Color(.gray), lineWidth: 2)
                                    .opacity(0.3),
                                alignment: .center // Opcional, alinea el borde al contenedor
                            )
                            .overlay(
                                Image(systemName: "magnifyingglass")
                                    .foregroundStyle(Color(red: 128/255, green: 97/255, blue: 225/255))
                                    .padding(.leading, 8),
                                alignment: .leading // Posición del ícono
                            )
                        
                        Button {
                            //action
                            viewModel.cityText = ""
                            Task {
                                await  viewModel.getCurrentLocation()
                                await weather5DaysViewModel.getWeather5Days(lat: viewModel.weatherResult.coord.lat, lon: viewModel.weatherResult.coord.lon)
                            }
                        } label: {
                            Image(systemName: "location.circle.fill")
                                .foregroundStyle(Color(red: 128/255, green: 97/255, blue: 225/255))
                                .font(.system(size: 30))
                        }

                        
                        
                    }
                    .padding(.bottom, 5)
                    
                    
                    // Location Icon with city and country
                    HStack {
                        Image(systemName: "mappin.circle.fill")
                            .font(.system(size: 30))
                            .foregroundStyle(Color(red: 128/255, green: 97/255, blue: 225/255))
                        Text(viewModel.cityCountryText)
                            .font(.system(size: 15))
                            .bold()
                            .foregroundStyle(Color(red: 128/255, green: 97/255, blue: 225/255))
                        Spacer()
                    }
                    
                    // Second Section: Today Forecast, feels like, temp min, temp max
                    VStack {
                        Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                            .foregroundStyle(.white)
                            .font(.system(size: 20))
                        HStack {
                            Image(systemName: viewModel.idStringIcon)
                                .font(.system(size: 80))
                            VStack {
                                Text(viewModel.tempString)
                                    .font(.system(size: 60))
                                    .bold()
                                Text(viewModel.weatherResult.weather.first?.main ?? "")
                                    .font(.system(size: 18))
                                    .bold()
                                    .multilineTextAlignment(.leading)
                            }
                        }
                        .foregroundStyle(.white)
                        .padding()
                        
                        HStack {
                            VStack {
                                Image(systemName: "thermometer.medium")
                                    .font(.system(size: 40))
                                
                                Text("Feels like")
                                    .font(.system(size: 18))
                                Text(viewModel.tempFeelsLikeString)
                                    .font(.system(size: 20))
                            }
                            .padding()
                            VStack {
                                Image(systemName: "arrow.down.circle.fill")
                                    .font(.system(size: 40))
                                Text("Temp min")
                                    .font(.system(size: 18))
                                Text(viewModel.tempMinString)
                                    .font(.system(size: 20))
                            }
                            .padding()
                            VStack {
                                Image(systemName: "arrow.up.circle.fill")
                                    .font(.system(size: 40))
                                Text("Temp max")
                                    .font(.system(size: 18))
                                Text(viewModel.tempMaxString)
                                    .font(.system(size: 20))
                            }
                            .padding()
                        }
                        .foregroundStyle(.white)
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: 425)
                    .background(LinearGradient(gradient: Gradient(colors: [
                        Color(red: 168/255, green: 154/255, blue: 225/255),
                        Color(red: 118/255, green: 96/255, blue: 244/255)
                    ]),
                                               startPoint: .topLeading,
                                               endPoint: .bottomLeading))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(radius: 10)
                    
                    // Third Section, forecast for 5 days per 3 hours
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: gridItem, spacing: 20) {
                            ForEach(weather5DaysViewModel.weatherData, id: \.dt) {item in
                                Weather5DaysView(weatherData: item)
                            }
                        }
                    }
                    .padding(.top, 10)
                    
                    Spacer()
                }
                
                .navigationTitle("Look a City")
                .padding()
                .onAppear {
                    Task {
                        await viewModel.getCurrentLocation()
                        await weather5DaysViewModel.getWeather5Days(lat: viewModel.weatherResult.coord.lat, lon: viewModel.weatherResult.coord.lon)
                    }
                }
            }
       
    }
}

#Preview {
    WeatherHomeView(viewModel: WeatherHomeViewModel())
}
