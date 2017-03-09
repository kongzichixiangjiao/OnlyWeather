//
//  OWCalendarCell.swift
//  OnlyWeather
//
//  Created by houjianan on 2017/3/9.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit

public let kOWCalendarCell = "OWCalendarCell"
public let kOWCalendarCellHeight: CGFloat = 44
class OWCalendarCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
}
