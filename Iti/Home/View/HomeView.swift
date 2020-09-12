//
//  HomeView.swift
//  Iti
//
//  Created by Matheus  Lima on 12/09/20.
//  Copyright © 2020 Alan Rabelo Martins. All rights reserved.
//

import UIKit

enum ImageNamed: String {
    case iconUser = "icouser"
    case eyeslash = "eye.slash"
    case icobottom = "icobottom"
}

class HomeView: UIView {
    //MARK: - ProfileContentView -
    private var viProfileContentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .mainViewHome
        return contentView
    }()
    private var ivProfileImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: ImageNamed.iconUser.rawValue)
        return image
    }()
    private var lbProfileName: UILabel = {
        let label = UILabel()
        label.backgroundColor = .mainViewHome
        label.font = .lbUserNameHome
        label.textColor = .white
        return label
    }()
    private var btnViewMyProfile: UIButton = {
        let button = UIButton()
        button.titleLabel?.text = StringsHelper.viewMyProfile
        return button
    }()
    private var viLineView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .lineViewHome
        return contentView
    }()
    
    //MARK: -Balance View-
    private var viBalanceContentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .mainViewHome
        return contentView
    }()
    private var lbBalanceDetail: UILabel = {
        let label = UILabel()
        label.backgroundColor = .mainViewHome
        label.font = .lbUserNameHome
        label.text = toCurrency(value: 100.0)
        label.textColor = .white
        return label
    }()
    private var btnViewMyBalance: UIButton = {
        let button = UIButton()
        let image = UIImage(named: ImageNamed.eyeslash.rawValue)
        button.setBackgroundImage(image, for: .normal)
        return button
    }()
    
    //MARK: - Carroussel -
    
    private var menuCollectionView: UICollectionView = {
        let collectionView = UICollectionView()
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 150, height: 189)
        
        
        return collectionView
    }()
    
    //MARK: - Footer View -
    private var btAllAboutIti: UIButton = {
        let button = UIButton()
        let image = UIImage(named: ImageNamed.icobottom.rawValue)
        button.setBackgroundImage(image, for: .normal)
        return button
    }()
    private var lbAllAboutIti: UILabel = {
        let label = UILabel()
        label.backgroundColor = .mainViewHome
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.text = StringsHelper.viewAllAboutMyIti
        label.textColor = .white
        return label
    }()
    
    
    
    
    
    //MARK: - AUX Methods -
    static func toCurrency(value: NSNumber) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        return currencyFormatter.string(from: value) ?? ""
    }
    
}
extension HomeView: CodeView {
    func setupComponents() {
        self.backgroundColor = .mainViewHome
        
    }
    
    func setupConstraints() {
        
    }
    
    func setupExtraConfigurations() {
        
    }
    
}
