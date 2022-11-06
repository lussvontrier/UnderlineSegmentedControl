//
//  UnderlineSegmentedControlOptions.swift
//  HandySwift
//
//  Created by Lusine Magauzyan on 02.11.22.
//

import UIKit

public struct UnderlineSegmentedControlOptions {
    var segmentTitleInsets: NSDirectionalEdgeInsets
    var segmentBackgroundColor: UIColor
    var segmentTitleFont: UIFont
    var segmentTitleColor: UIColor
    var selectedSegmentTitleColor: UIColor
    var underlineColor: UIColor
    var underlineHeight: Double
    
    init(segmentTitleInsets: NSDirectionalEdgeInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0), segmentBackgroundColor: UIColor = UIColor.white, segmentTitleFont: UIFont = UIFont.systemFont(ofSize: 20), segmentTitleColor: UIColor = UIColor.lightGray, selectedSegmentTitleColor: UIColor = UIColor.blue, underlineColor: UIColor = UIColor.blue, underlineHeight: Double = 4.0) {
        self.segmentTitleInsets = segmentTitleInsets
        self.segmentBackgroundColor = segmentBackgroundColor
        self.segmentTitleFont = segmentTitleFont
        self.segmentTitleColor = segmentTitleColor
        self.selectedSegmentTitleColor = selectedSegmentTitleColor
        self.underlineColor = underlineColor
        self.underlineHeight = underlineHeight
    }
}
