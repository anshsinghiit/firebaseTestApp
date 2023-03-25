//
//  HeaderTableCell.swift
//  TestApp
//
//  Created by Ansh Singh on 25/03/23.
//

import Foundation
import UIKit
import SDWebImage

class HeaderTableCell: TableViewCell {
    
    var titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    var textView1: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 0
        text.lineBreakMode = .byWordWrapping
        return text
    }()
    
    var textView2: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 0
        text.lineBreakMode = .byWordWrapping
        return text
    }()
    
    var centerImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 16
        image.clipsToBounds = true
        return image
    }()
    
    override func configure(_ item: Any?) {
        guard let model = item as? Lesson else {return}
        self.createViews(model: model)
        titleLabel.text = model.title
        textView1.text = model.subtitle
        textView2.text = model.description
        centerImage.sd_setImage(with: URL(string: model.coverImage))
    }
    
    
    func createViews(model: Lesson) {
        selectionStyle = .none
        addSubview(titleLabel)
        addSubview(textView1)
        addSubview(textView2)
        addSubview(centerImage)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            textView1.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            textView1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            textView1.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            centerImage.topAnchor.constraint(equalTo: textView1.bottomAnchor, constant: 8),                                          centerImage.heightAnchor.constraint(equalToConstant: 150),
            centerImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            centerImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32),
            
            textView2.topAnchor.constraint(equalTo: centerImage.bottomAnchor, constant: 8),
            textView2.leadingAnchor.constraint(equalTo: centerImage.leadingAnchor),
            textView2.trailingAnchor.constraint(equalTo: centerImage.trailingAnchor),
            textView2.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
        ])
    }
}
