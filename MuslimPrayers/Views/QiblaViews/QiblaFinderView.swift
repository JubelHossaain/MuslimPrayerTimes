//
//  QiblaFinderView.swift
//  MuslimPrayers
//
//  Created by Appnap WS13 on 12/17/22.
//

import SwiftUI

struct QiblaFinderView: View {
    var body: some View {
        NavigationView{
            CompassViewUIkit()
                .navigationTitle("Qibla Finder")
        }
    }
}

struct QiblaFinderView_Previews: PreviewProvider {
    static var previews: some View {
        QiblaFinderView()
    }
}
