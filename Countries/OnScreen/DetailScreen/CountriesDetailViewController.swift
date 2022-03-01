//
//  CountriesDetailViewController.swift
//  Countries
//
//  Created by huseyin.kucuk on 1.03.2022.
//

import UIKit
import SDWebImageSVGCoder

class CountriesDetailViewController: UIViewController {
    
    private lazy var countryFlagImageView: UIImageView = {
        let countryFlagimage = UIImageView()
        countryFlagimage.contentMode = .scaleToFill
        return countryFlagimage
    }()
    
    private lazy var countryCodeStaticLabel: UILabel = {
        let countryCodeLabel = UILabel()
        countryCodeLabel.text = "Country Code:"
        countryCodeLabel.textAlignment = .left
        countryCodeLabel.textColor = .systemRed
        countryCodeLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return countryCodeLabel
    }()
    
    private lazy var countryCodeDynamicLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemRed
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var redirectButton: UIButton = {
        let moreInformationButton = UIButton()
        moreInformationButton.setTitle("For More Information ->", for: .normal)
        moreInformationButton.setTitleColor(UIColor.systemRed, for: .normal)
        moreInformationButton.backgroundColor = .secondarySystemBackground
        moreInformationButton.addTarget(self, action: #selector(moreInformationButtonTapped), for: .touchUpInside)
        return moreInformationButton
    }()
    
    private lazy var saveButton: UIButton = {
        let favoriteGestureButton = UIButton()
        favoriteGestureButton.setImage(UIImage(systemName: "heart"), for: .normal)
        favoriteGestureButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        favoriteGestureButton.tintColor = .systemRed
        favoriteGestureButton.imageView?.contentMode = .scaleAspectFit
        favoriteGestureButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        return favoriteGestureButton
    }()
    
    private lazy var goBackButton: UIButton = {
        let backButton = UIButton()
        backButton.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backButton.tintColor = .systemRed
        backButton.addTarget(self, action: #selector(goBackButtonTapped), for: .touchUpInside)
        return backButton
    }()
    
    public var countryModel: CountryDetailModel?
    private var favorites = FavoriteStore.favorites ?? []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataForCountryFlag()
        prepareUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        self.title = countryModel?.name
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: goBackButton)
        saveButton.isSelected = favorites.contains(countryModel?.code ?? "")
    }
    
    private func prepareUI() {
        view.backgroundColor = .systemBackground
        
        self.view.addSubview(countryFlagImageView)
        countryFlagImageView.snp.makeConstraints { make in
            make.top.equalTo(view.layoutMarginsGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
        
        self.view.addSubview(countryCodeStaticLabel)
        countryCodeStaticLabel.snp.makeConstraints { make in
            make.top.equalTo(countryFlagImageView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        self.view.addSubview(countryCodeDynamicLabel)
        countryCodeDynamicLabel.snp.makeConstraints { make in
            make.top.equalTo(countryFlagImageView.snp.bottom).offset(20)
            make.leading.equalTo(countryCodeStaticLabel.snp.trailing).offset(10)
        }
        
        self.view.addSubview(redirectButton)
        redirectButton.snp.makeConstraints { make in
            make.top.equalTo(countryCodeStaticLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(230)
            make.height.equalTo(46)
        }
    }
    
    private func getDataForCountryFlag() {
        let SVGCoder = SDImageSVGCoder.shared
        SDImageCodersManager.shared.addCoder(SVGCoder)
        countryFlagImageView.sd_setImage(with: URL(string: countryModel?.flagImageURI ?? ""), placeholderImage: UIImage(systemName: "photo.circle"), options: .continueInBackground, context: nil)
        
        countryCodeDynamicLabel.text = countryModel?.code
    }
    
    @objc func favoriteButtonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        let code = countryModel?.code ?? ""
        
        if sender.isSelected {
            self.favorites.append(code)
        } else {
            self.favorites = self.favorites.filter( {$0 != code} )
        }
        FavoriteStore.favorites = self.favorites
    }
    
    @objc func goBackButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func moreInformationButtonTapped() {
        let wikiDataId = countryModel?.wikiDataID ?? ""
        
        if let url = URL(string: "https://www.wikidata.org/wiki/" + wikiDataId) {
            UIApplication.shared.open(url)
        }
    }
    
}
