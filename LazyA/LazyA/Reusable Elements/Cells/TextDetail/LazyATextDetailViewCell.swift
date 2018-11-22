//
//  LazyATextDetailViewCell.swift
//  LazyA
//
//  Created by Michael Isasi on 11/16/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import UIKit

protocol EasilyRegisterableCell where Self : UIView {
    static var name : String { get }
    static var nib: UINib  { get }
}

extension EasilyRegisterableCell {
    static var name : String {
        return String(describing: self)
    }
    
    static var nib : UINib {
        return UINib(nibName: name, bundle: nil)
    }
}

extension UITableView {
    func register( cell : EasilyRegisterableCell.Type ) {
        self.register(cell.nib, forCellReuseIdentifier: cell.name)
    }
}

extension UICollectionView {
    func register( cell : EasilyRegisterableCell.Type ) {
        self.register(cell.nib, forCellWithReuseIdentifier: cell.name)
    }
}

class LazyATextDetailViewCell: UITableViewCell, EasilyRegisterableCell {

    @IBOutlet weak var mainTextLabel: LazyALabel!
    @IBOutlet weak var subTextLabel: LazyALabel!
    @IBOutlet weak var containmentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.containmentView.layer.cornerRadius = 5
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
