//
//  MuslimPrayersApp.swift
//  MuslimPrayers
//
//  Created by Appnap WS13 on 12/4/22.
//

import SwiftUI

@main
struct MuslimPrayersApp: App {
    @Environment(\.colorScheme) var colorScheme
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.colorScheme, .dark)
        }
    }
}
