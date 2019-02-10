//
//  CompletionSegmentedControl.swift
//  LazyA
//
//  Created by Michael Isasi on 11/30/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import UIKit

protocol CompletionSegmentedControlDelegate : AnyObject {
    func completionSegmentedControl( completionSegmentedControl : CompletionSegmentedControl, didSelectCompletionStatus status : CompletionStatus?)
}

final class CompletionSegmentedControl: LazyASegmentedControl {
    
    var value : CompletionStatus? {
        didSet {
            delegate?.completionSegmentedControl(completionSegmentedControl: self, didSelectCompletionStatus: value)
        }
    }
    
    weak var delegate : CompletionSegmentedControlDelegate?
    
    override func setUp() {
        super.setUp()
        var segments = [String]()
        segments.append("All")
//
        CompletionStatus.allCases.forEach {
            segments.append($0.rawValue)
        }
        self.replaceSegments(with : segments)
//
        self.addTarget(self, action: #selector(CompletionSegmentedControl.segmentedControlValueChanged), for:.valueChanged)
        self.layoutSubviews()
        self.updateConstraints()
    }
    @objc private func segmentedControlValueChanged() {
        self.value = CompletionStatus(rawValue: self.titleForSegment(at: self.selectedSegmentIndex) ?? "")
    }
}

extension UISegmentedControl {
    func replaceSegments(with segments: Array<String>) {
        self.removeAllSegments()
        for segment in segments {
            self.insertSegment(withTitle: segment, at: self.numberOfSegments, animated: false)
        }
    }
}
