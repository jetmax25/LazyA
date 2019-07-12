//
//  HorizontalPicker.swift
//  LazyA
//
//  Created by Michael Isasi on 12/1/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import UIKit


/// UIPickerview but horizontal
class HorizontalPicker: UIPickerView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    var oldFrame : CGRect?
    var newFrame : CGRect?
    var oldBounds : CGRect?
    var newBounds : CGRect?
    
    let rotationAngle = 90 * (Double.pi / 180)
    private func setUp() {
        self.translatesAutoresizingMaskIntoConstraints = true
        self.oldFrame = self.frame
        self.oldBounds = self.bounds
        let frame = self.frame
        print(self.frame)
        self.transform = CGAffineTransform(rotationAngle: CGFloat(rotationAngle))
        self.frame = frame
        self.newFrame = self.frame
        self.newBounds = self.bounds
        self.delegate = self
        self.dataSource = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    //    setUp()
    }
}

extension HorizontalPicker : UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return self.frame.width
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let size = self.rowSize(forComponent: component)
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: size.width))
        view.backgroundColor = row % 2 == 0 ? UIColor.red : UIColor.green
        let label = UILabel(frame: view.frame)
        label.text = "December"
        label.textAlignment = .center
        view.addSubview(label)
        view.transform = CGAffineTransform(rotationAngle: CGFloat(-rotationAngle))
        return view
    }
}
