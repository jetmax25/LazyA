//
//  NumberPicker.swift
//  LazyA
//
//  Created by Michael Isasi on 11/16/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import UIKit



protocol NumberPickerDelegate {
    var value : Int { get }
}

@IBDesignable
class NumberPicker: UIPickerView, NumberPickerDelegate,  UIPickerViewDelegate, UIPickerViewDataSource {
    
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
        return Int(pow(10.0, Double(NumDigits - component)))
    }
    
    private func row(of value : Int, for component : Int) -> Int {
        return Int(value / exponent(for: component))
    }
    
    private func value(of component : Int) -> Int {
        return self.selectedRow(inComponent: component) * exponent(for: component)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return NumDigits
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row)
    }
    
    @IBInspectable var NumDigits : Int = 2
    @IBInspectable var InitialValue : Int = 0 {
        didSet {
            for index in 0..<NumDigits {
                self.selectRow(row(of: InitialValue, for: index), inComponent: index, animated: false)
            }
        }
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
        self.backgroundColor = UIColor.Pallet.Touch
        self.delegate = self
        self.dataSource = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUp()
    }
    
}
