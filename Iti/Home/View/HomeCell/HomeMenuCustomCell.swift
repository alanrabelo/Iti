//
//  HomeMenuCustomCell.swift
//  Iti
//
//  Created by Matheus  Lima on 12/09/20.
//  Copyright © 2020 Alan Rabelo Martins. All rights reserved.
//

import UIKit

class HomeMenuCustomCell: UICollectionViewCell {
    private var image: UIImage?
     let ivCell: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 10
        return iv
    }()
    private var menuCollectionViewCell: UICollectionViewCell = {
        let cell = UICollectionViewCell()
        return cell
    }()
    func setImageCell(image: UIImage) {
        self.ivCell.image = image
    }
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(ivCell)
    }
    func setupContraints() {
        ivCell.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        ivCell.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        ivCell.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        ivCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
