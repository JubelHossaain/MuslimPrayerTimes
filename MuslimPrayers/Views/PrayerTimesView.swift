//
//  PrayerTimesView.swift
//  MuslimPrayers
//
//  Created by Appnap WS13 on 12/17/22.
//

import SwiftUI

struct PrayerTimesView: View{
    @State var todayTimes:[(AKPrayerTime.TimeNames, Any)] = []
    var body: some View{
        ZStack{
            NavigationView{
                List{
                    ForEach(0..<todayTimes.count, id: \.self) { index in
                        let (timeName, time) = todayTimes[index]
                        HStack{
                            Text("\(timeName.toString())")
                            Spacer()
                            Text("\(time as! String)")
                        }
                    }
                }
                .navigationTitle("Prayer times")
            }
        }.onAppear{
            let prayerKit:AKPrayerTime = AKPrayerTime(lat: 23.810332, lng: 90.4125181)
            prayerKit.calculationMethod = .Karachi
            prayerKit.asrJuristic = .Hanafi
            prayerKit.outputFormat = .Time12
            let times = prayerKit.getPrayerTimes()
            if let t = times {
                let sortedTimes = t.sorted {a,b in a.0.rawValue < b.0.rawValue}
                todayTimes = sortedTimes
                for (pName, time) in sortedTimes {
                    let paddedName:String = (pName.toString() as NSString).padding(toLength: 15, withPad: " ", startingAt: 0)
                    print(paddedName  + " : \(time)")
                }
            }
        }
        
    }
}

struct PrayerTimesView_Previews: PreviewProvider {
    static var previews: some View {
        PrayerTimesView()
    }
}
