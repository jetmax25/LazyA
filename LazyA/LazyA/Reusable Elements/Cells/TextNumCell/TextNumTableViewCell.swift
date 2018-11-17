//
//  TextNumTableViewCell.swift
//  LazyA
//
//  Created by Michael Isasi on 11/17/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import UIKit

class TextNumTableViewCell: UITableViewCell, EasilyRegisterableCell {

    @IBOutlet weak var containerView: UIStackView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var numberPicker: NumberPicker!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension TextNumTableViewCell : NumberPickerDelegate {
    func NumberPicker(numberPicker: NumberPicker, didChange value: Int) {
        print(value)
    }
}
