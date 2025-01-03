//
//  LoadingView.swift
//  WeatherApp
//
//  Created by Andy Heredia on 3/1/25.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView()
                .progressViewStyle(.circular)
                .tint(.white)
                .scaleEffect(1.3)
                .padding(.bottom, 5)
                
            Text("Loading...")
                .foregroundStyle(.white)
                .bold()
                .font(.system(size: 20))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [
            Color(red: 168/255, green: 154/255, blue: 225/255),
            Color(red: 118/255, green: 96/255, blue: 244/255)
        ]),
                                   startPoint: .topLeading,
                                   endPoint: .bottomLeading))
        .shadow(radius: 2)
        .ignoresSafeArea()
        
       
    }
}

#Preview {
    LoadingView()
}
