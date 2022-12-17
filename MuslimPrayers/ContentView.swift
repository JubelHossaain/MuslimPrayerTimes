//
//  ContentView.swift
//  MuslimPrayers
//
//  Created by Appnap WS13 on 12/4/22.
//

import SwiftUI
import Combine
import CoreLocation


struct ContentView : View {
    var body: some View {
        TabView {
            QuranView()
                .tabItem {
                    Label("Quran Menu", systemImage: "book")
                }
            
            QiblaFinderView()
                .tabItem {
                    Label("Qibla", systemImage: "location.north")
                }
            PrayerTimesView()
                .tabItem {
                    Label("Prayer Times", systemImage: "clock.arrow.2.circlepath")
                }
        }.ignoresSafeArea()
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
