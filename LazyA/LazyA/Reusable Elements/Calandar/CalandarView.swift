//
//  CalandarView.swift
//  LazyA
//
//  Created by Michael Isasi on 12/1/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import UIKit

protocol CalandarViewDataSource {
    func CalandarView( calandarView : CalandarView, numberOfItemsFor date : SimpleDate ) -> Int
}

protocol CalandarViewDelegate {
    func CalandarView( calandarView : CalandarView, didSelect date : SimpleDate)
}

/**
 Calandar that display the number of items on that day
 */
class CalandarView : ReusableView {
    @IBOutlet weak var todayButton: UIButton!
    @IBOutlet weak var calandarCollectionView: UICollectionView!
    @IBOutlet weak var monthLabel: LazyALabel!
    @IBOutlet weak var yearLabel: LazyALabel!
    
    var dataSource : CalandarViewDataSource?
    var delegate : CalandarViewDelegate?
    
    
    /// Maps the date to the number of items set on that date
    private var itemsForDate = [SimpleDate : Int]()
    
    private func updateDayOffset() {
        self.dayOffset = SimpleDate(day: 1, month: self.date.month, year: self.date.year).date.dayOfTheWeek - 1
    }
    
    ///Store the offset of the starting day of the month
    private var dayOffset : Int = 0

    private var date : SimpleDate = SimpleDate.today {
        didSet {
            self.monthLabel.text = date.month.name
            self.yearLabel.text = String(date.year)
            self.updateDayOffset()
            self.calandarCollectionView.reloadData()
        }
    }

    static var nib: UINib {
        print(String(describing: self) )
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
    
    override func setUp() {
        super.setUp()
        print(SimpleDate.today.date.dayOfTheWeek)
        self.calandarCollectionView.delegate = self
        self.calandarCollectionView.dataSource = self
        self.calandarCollectionView.register(cell: CalandarSimpleViewCell.self)
        self.date = SimpleDate.today
    }
    
    ///Go to previous month
    @IBAction func previousMonth(_ sender: Any) {
        self.date = self.date.get(direction: .previous, component: .month)
    }
    
    ///Go to next month
    @IBAction func nextMonth(_ sender: Any) {
        self.date = self.date.get(direction: .next, component: .month)
    }
    
    ///Go to today
    @IBAction func goToToday(_ sender: Any) {
        self.date = SimpleDate.today
    }
}

extension CalandarView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private func day( for indexPath : IndexPath ) -> Int {
        return indexPath.row + 1 - dayOffset
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return date.month.days(for: date.year) + dayOffset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 6) / 7
        let height = (collectionView.frame.height - 4) / 5
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalandarSimpleViewCell.name, for: indexPath) as! CalandarSimpleViewCell
        
        if indexPath.row < self.dayOffset {
            cell.alpha = 0.0
            return cell
        }
    
        let dayNum = day(for: indexPath)
        let simpleDate = SimpleDate(day: dayNum, month: self.date.month, year: self.date.year)
        cell.simpleDate = simpleDate
        cell.numItems = dataSource?.CalandarView(calandarView: self, numberOfItemsFor: simpleDate) ?? 0
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            return
        }
        let dayNum = day(for: indexPath)
        let date = SimpleDate(day: dayNum, month: self.date.month, year: self.date.year)
        self.delegate?.CalandarView(calandarView: self, didSelect: date)
    }
}
