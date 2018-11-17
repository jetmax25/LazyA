//
//  NumberPicker.swift
//  LazyA
//
//  Created by Michael Isasi on 11/16/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import UIKit

protocol NumberPickerDelegate : class {
    func NumberPicker( numberPicker : NumberPicker, didChange value : Int)
}

@IBDesignable
class NumberPicker: UIView, NibFileOwnerLoadable {

    @IBOutlet weak private var picker: UIPickerView!
    
    @IBInspectable var NumDigits : Int = 2
    @IBInspectable var InitialValue : Int = 0
    
    weak var delegate : NumberPickerDelegate?
    
    var value: Int {
        get {
            var _value = 0
            for index in 0..<NumDigits {
                _value += self.value(of: index)
            }
            return _value
        }
    }

    private func exponent( for component : Int) -> Int {
        return Int(pow(10.0, Double(NumDigits - (component + 1))))
    }

    private func row(of value : Int, for component : Int) -> Int {
        return Int(value / exponent(for: component)) % 10
    }

    private func value(of component : Int) -> Int {
        return picker.selectedRow(inComponent: component) * exponent(for: component)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    private func setUp() {
        loadNibContent()
        self.backgroundColor = UIColor.red
        setInitialValue()
    }
    
    private func setInitialValue() {
        for index in 0..<NumDigits {
            picker.selectRow(row(of: InitialValue, for: index), inComponent: index, animated: false)
        }
    }
    
    override func layoutSubviews() {
        setUp()
    }
}

extension NumberPicker : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return NumDigits
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row)
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return (self.bounds.width / CGFloat(NumDigits)) - 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.NumberPicker(numberPicker: self, didChange: self.value)
    }
}


