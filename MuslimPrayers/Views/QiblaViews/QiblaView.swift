//
//  QiblaView.swift
//  MuslimPrayers
//
//  Created by Appnap WS13 on 12/17/22.
//

import SwiftUI

struct QiblaView: View {
    @ObservedObject var compassHeading = CompassHeading()
    var body: some View{
        NavigationView{
            VStack {
                Capsule()
                    .frame(width: 5,
                           height: 50)
                
                ZStack {
                    ForEach(Marker.markers(), id: \.self) { marker in
                        CompassMarkerView(marker: marker,
                                          compassDegress: self.compassHeading.degrees)
                    }
                }
                .frame(width: 300,
                       height: 300)
                .rotationEffect(Angle(degrees: self.compassHeading.degrees))
                .statusBar(hidden: true)
                Text("\(Int(self.compassHeading.degrees))")
                
            }
            .navigationTitle("Qibla Finder")
        }
    }
}
struct QiblaView_Previews: PreviewProvider {
    static var previews: some View {
        QiblaView()
    }
}
