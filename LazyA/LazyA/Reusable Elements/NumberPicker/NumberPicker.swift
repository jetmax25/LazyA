//
//  NumberPicker.swift
//  LazyA
//
//  Created by Michael Isasi on 11/16/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import UIKit

protocol NumberPickerDelegate : class {
    func numberPicker( numberPicker : NumberPicker, didChange value : Int)
}

class NumberPicker: ReusableView{
    
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
        } set {
            self.InitialValue = newValue
            self.setInitialValue()
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
    
    override internal func setUp() {
        super.setUp()
        setInitialValue()
    }
    
    private func setInitialValue() {
        for index in 0..<NumDigits {
            picker.selectRow(row(of: InitialValue, for: index), inComponent: index, animated: false)
        }
    }
}

extension NumberPicker : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return NumDigits
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return (self.bounds.width / CGFloat(NumDigits)) - 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.numberPicker(numberPicker: self, didChange: self.value)
    }
    
//    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
//        return self.bounds.height
//    }
    
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//        let frame = CGRect(x: 0, y: 0, width: pickerView.rowSize(forComponent: component).width, height: pickerView.rowSize(forComponent: component).height)
//        let pickerView = UIView(frame: frame)
//        pickerView.backgroundColor = UIColor.blue
//        return pickerView
//    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row)
    }
}


