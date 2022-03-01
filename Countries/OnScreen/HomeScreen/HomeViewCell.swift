//
//  HomeViewCell.swift
//  Countries
//
//  Created by huseyin.kucuk on 1.03.2022.
//

import Foundation

import UIKit

protocol CountryCellDelegate: AnyObject {
    func isFavoriteButtonTapped(code: String, isSelected: Bool)
}

class HomeViewCell: UITableViewCell {
    
    private lazy var countryNameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = .systemRed
        nameLabel.backgroundColor = .clear
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        return nameLabel
    }()
    
    private lazy var favoriteButton: UIButton = {
        let favorite = UIButton()
        favorite.setImage(UIImage(systemName: "heart"), for: .normal)
        favorite.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        favorite.tintColor = .systemRed
        favorite.imageView?.contentMode = .scaleAspectFit
        favorite.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        return favorite
    }()
    
    private lazy var borderView: UIView = {
        let border = UIView()
        border.backgroundColor = .secondarySystemBackground
        border.layer.borderWidth = 1
        border.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        border.layer.cornerRadius = 6
        return border
    }()
    
    weak var delegate: CountryCellDelegate?
    private var code = ""
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        prepareBorder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareBorder() {
        self.contentView.addSubview(borderView)
        borderView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(5)
        }
        
        borderView.addSubview(favoriteButton)
        favoriteButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.size.equalTo(30)
        }
        
        borderView.addSubview(countryNameLabel)
        countryNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(favoriteButton.snp.leading).offset(-10)
        }
    }
    
    @objc private func favoriteButtonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        delegate?.isFavoriteButtonTapped(code: self.code, isSelected: sender.isSelected)
    }
    
    func getDataForCountry(name: String, code: String, isSelected: Bool) {
        countryNameLabel.text = name
        self.code = code
        favoriteButton.isSelected = isSelected
    }
    
}
