//
//  CustomTableViewCell.swift
//  PhotosDemo
//
//  Created by Gamze Güven on 20.04.2020.
//  Copyright © 2020 Gamze Güven. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    lazy var resultImage: UIImageView = {
        let resultImage = UIImageView()
        resultImage.translatesAutoresizingMaskIntoConstraints = false
        resultImage.contentMode = .scaleAspectFit
        return resultImage
    }()
    
    lazy var idLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .left
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.numberOfLines = 1
        return lbl
    }()
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .blue

        contentView.addSubview(resultImage)
        contentView.addSubview(idLabel)
        contentView.addSubview(titleLabel)

        var constraints = [
            resultImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5, constant: 0),
            resultImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -40),
            resultImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -20),
            resultImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)

        let labelStack = UIStackView(arrangedSubviews: [idLabel, titleLabel])
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        labelStack.alignment = .fill
        labelStack.axis = .vertical

        contentView.addSubview(labelStack)

        constraints = [
            labelStack.leadingAnchor.constraint(equalTo: resultImage.trailingAnchor, constant: -30),
            labelStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            labelStack.heightAnchor.constraint(equalTo: resultImage.heightAnchor),
            labelStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
        resultImage.layer.cornerRadius = 10
        resultImage.clipsToBounds = true
    }
}
