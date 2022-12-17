//
//  Surah.swift
//  MuslimPrayers
//
//  Created by Appnap WS13 on 12/17/22.
//

import Foundation


struct Surah : Codable{
    var data : [Data]
}


struct Data : Codable, Identifiable{
    var number : Int
    var name : String
    var englishName : String
    var englishNameTranslation : String
    var numberOfAyahs : Int
    var revelationType : String
    var id :Int {number}
    
}
