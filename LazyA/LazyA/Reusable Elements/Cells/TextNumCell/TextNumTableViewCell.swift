//
//  TextNumTableViewCell.swift
//  LazyA
//
//  Created by Michael Isasi on 11/17/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import UIKit

protocol TextNumTableViewCellDelegate : class {
    func textNumTableViewCell( didUpdateCellAt indexPath : IndexPath, text : String, num : Int )
}

class TextNumTableViewCell: UITableViewCell, EasilyRegisterableCell {

    @IBOutlet weak var containerView: UIStackView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var numberPicker: NumberPicker!
    var indexPath : IndexPath?
    
    weak var delegate : TextNumTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.numberPicker.delegate = self
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func updateText(_ sender: Any) {
        update()
    }
    
    func update() {
        guard let indexPath = indexPath else {
            return
        }
        let text = (self.textField.text ?? "").capitalizingFirstLetter()
        self.textField.text = text
        delegate?.textNumTableViewCell(didUpdateCellAt: indexPath, text: text, num: numberPicker.value)
    }
    
}

extension TextNumTableViewCell : NumberPickerDelegate {
    func numberPicker(numberPicker: NumberPicker, didChange value: Int) {
        update()
    }
}
