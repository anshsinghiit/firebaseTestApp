//
//  TopicTableCell.swift
//  TestApp
//
//  Created by Ansh Singh on 25/03/23.
//

import Foundation
import UIKit

class TopicTableCell: TableViewCell {
    var topImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 16
        image.clipsToBounds = true
        return image
    }()
    
    var bottomImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 16
        image.clipsToBounds = true
        return image
    }()
    
    var body: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 0
        text.lineBreakMode = .byWordWrapping
        return text
    }()
    
    var titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    var topHeightConstraint: NSLayoutConstraint!
    var bottomHeightConstaint: NSLayoutConstraint!
    
    override func configure(_ item: Any?) {
        guard let model = item as? Topic else {return}
        self.createViews(model: model)
        body.text = model.topicDescription
        titleLabel.text = model.topicTitle
        if model.imageAtTop {
            topImage.sd_setImage(with: URL(string: model.topicImage))
            topHeightConstraint.constant = 150
            bottomHeightConstaint.constant = 0
        } else {
            bottomImage.sd_setImage(with: URL(string: model.topicImage))
            bottomHeightConstaint.constant = 150
            topHeightConstraint.constant = 0
        }
        self.backgroundColor = UIColor(hexString: model.bgColor, alpha: 1)
        self.layoutSubviews()
        
    }
    
    func createViews(model: Topic) {
        selectionStyle = .none
        addSubview(topImage)
        addSubview(bottomImage)
        addSubview(body)
        addSubview(titleLabel)
        
        topHeightConstraint = topImage.heightAnchor.constraint(equalToConstant: 150)
        bottomHeightConstaint = bottomImage.heightAnchor.constraint(equalToConstant: 150)
        
        NSLayoutConstraint.activate([
            topImage.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            topImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            topImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32),
            topHeightConstraint,
            
            titleLabel.topAnchor.constraint(equalTo: topImage.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: topImage.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: topImage.trailingAnchor),
            
            body.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            body.leadingAnchor.constraint(equalTo: topImage.leadingAnchor),
            body.trailingAnchor.constraint(equalTo: topImage.trailingAnchor),
            
            bottomImage.topAnchor.constraint(equalTo: body.bottomAnchor, constant: 8),
            bottomImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            bottomImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32),
            bottomImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            bottomHeightConstaint
        ])
        
    }
}

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}
