//
//  GeographyInfoView.swift
//  CompassExample
//
//  Created by Liu Chuan on 2020/5/14.
//  Copyright © 2020 LC. All rights reserved.
//

import UIKit


/// Geolocation Information View
class GeographyInfoView: UIView {
    
    //MARK: - Control Properties
    /// angle label
    @IBOutlet weak var angleLabel: UILabel!
    /// directuib label
    @IBOutlet weak var directionLabel: UILabel!
    /// latitudeAndLongitude Label
    @IBOutlet weak var latitudeAndLongitudeLabel: UILabel!
    /// position Label
    @IBOutlet weak var positionLabel: UILabel!
    /// altitude Label
    @IBOutlet weak var altitudeLabel: UILabel!
    
}

//MARK: - View Life Cycle
extension GeographyInfoView {
    
    /* load nib*/
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}

//MARK: - GeographyInfoView extention
extension GeographyInfoView {
    
    /// Provide a class method to quickly create through Xib
    ///
    /// - Returns: GeographyInfoView
    class func loadingGeographyInfoView() -> GeographyInfoView {
        return Bundle.main.loadNibNamed("GeographyInfoView", owner: nil, options: nil)?.first as! GeographyInfoView
    }
    
}
