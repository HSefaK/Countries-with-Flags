//
//  HomeView.swift
//  Countries
//
//  Created by huseyin.kucuk on 1.03.2022.
//

import UIKit
import SnapKit

class HomeView: UIViewController {
    private lazy var tableViewForCountries: UITableView = {
        let tableView = UITableView()
        
        tableView.register(HomeViewCell.self, forCellReuseIdentifier: "country")
        tableView.rowHeight = 60
        tableView.backgroundColor = .secondarySystemBackground
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    private var countries: [CountryModal]?
    private var favorites = FavoriteStore.favorites ?? []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
        getCountryData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "Countries"
        favorites = FavoriteStore.favorites ?? []
        self.tableViewForCountries.reloadData()
    }
    
    private func setTableView() {
        self.view.addSubview(tableViewForCountries)
        tableViewForCountries.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func getCountryData() {
        Network.shared.getCountries { model in
            self.countries = model?.data
            self.tableViewForCountries.reloadData()
        }
    }
    
}

extension HomeView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "country", for: indexPath) as! HomeViewCell
        if let model = countries?[indexPath.row] {
            var isSelected = false
            if self.favorites.contains(model.code) {
                isSelected = true
            }
            cell.getDataForCountry(name: model.name, code: model.code, isSelected: isSelected)
        }
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let countryCode = countries?[indexPath.row].code ?? ""
        Network.shared.getCountryDetails(countryCode: countryCode, { model in
            let countryDetailController = CountriesDetailViewController()
            countryDetailController.countryModel = model?.data
            self.navigationController?.pushViewController(countryDetailController, animated: true)
        })
    }
    
}

extension HomeView: CountryCellDelegate {
    
    func isFavoriteButtonTapped(code: String, isSelected: Bool) {
        if isSelected {
            self.favorites.append(code)
            FavoriteStore.favorites = self.favorites
        } else {
            self.favorites = self.favorites.filter( {$0 != code} )
            FavoriteStore.favorites = self.favorites
        }
    }
    
}
