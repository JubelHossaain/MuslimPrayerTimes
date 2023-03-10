//
//  SurahDetail.swift
//  MuslimPrayers
//
//  Created by Appnap WS13 on 12/17/22.
//

import Foundation

struct SurahDetailModel : Codable{
    var data : DataDetail
}
struct DataDetail : Codable{
    var name : String
    var englishName : String
    var englishNameTranslation : String
    var revelationType : String
    var numberOfAyahs : Int
    var ayahs : [Ayahs]
}

struct Ayahs : Codable, Identifiable{
    var number : Int
    var audio : String
    var text : String
    var id : Int{number}
}
