//
//  SavedCountriesViewController.swift
//  Countries
//
//  Created by huseyin.kucuk on 1.03.2022.
//

import UIKit

class SavedCountriesViewController: UIViewController {
    
    private lazy var savedCountriesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(HomeViewCell.self, forCellReuseIdentifier: "country")
        tableView.rowHeight = 55
        tableView.backgroundColor = .secondarySystemBackground
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.style = .large
        indicatorView.color = .white
        indicatorView.layer.zPosition = 1
        return indicatorView
    }()
    
    private var countries: [CountryModal]?
    private var favorites = FavoriteStore.favorites ?? []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "Saved"
        getCountry()
    }
    
    private func setupUI() {
        self.view.addSubview(savedCountriesTableView)
        
        savedCountriesTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func getCountry() {
        activityIndicator.startAnimating()
        Network.shared.getCountries { model in
            self.countries = model?.data
            
            self.getFilteredCountries { model in
                self.countries = model
                self.activityIndicator.stopAnimating()
                self.savedCountriesTableView.reloadData()
            }
        }
    }
    
    private func getFilteredCountries(_ completion: @escaping([CountryModal]) -> Void) {
        guard let getCountries = self.countries else { return }
        self.favorites = FavoriteStore.favorites ?? []
        completion(getCountries.filter( {self.favorites.contains($0.code)} ))
    }
}

extension SavedCountriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "country", for: indexPath) as! HomeViewCell
        
        if let model = countries?[indexPath.row] {
            cell.getDataForCountry(name: model.name, code: model.code, isSelected: true)
        }
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let getCodeOfCountry = countries?[indexPath.row].code ?? ""
        Network.shared.getCountryDetails(countryCode: getCodeOfCountry, { model in
            let countryDetailController = CountriesDetailViewController()
            countryDetailController.countryModel = model?.data
            self.navigationController?.pushViewController(countryDetailController, animated: true)
        })
    }
}

extension SavedCountriesViewController: CountryCellDelegate {
    
    func isFavoriteButtonTapped(code: String, isSelected: Bool) {
        if isSelected {
            self.favorites.append(code)
            FavoriteStore.favorites = self.favorites
        } else {
            self.favorites = self.favorites.filter( {$0 != code} )
            FavoriteStore.favorites = self.favorites
            
            getFilteredCountries { model in
                self.countries = model
                self.savedCountriesTableView.reloadData()
            }
        }
    }
    
}
