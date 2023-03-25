//
//  TableViewCell.swift
//  TestApp
//
//  Created by Ansh Singh on 25/03/23.
//

import Foundation
import UIKit

class TableViewCell: UITableViewCell {
    
    var item: Any? {
        didSet {
            self.configure(self.item)
        }
    }
    
    weak var delegate: NSObjectProtocol?
    
    func configure(_ item: Any?) {
        
    }
    
}
