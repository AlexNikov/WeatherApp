//
//  CitySearchViewController.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 31.07.2021.
//

import UIKit
import SnapKit

class CitySearchViewController: UIViewController {

	var updateCityHandler: MainTabUpdateCityCompletion?
    let tableView = UITableView()
    let searchBar = UISearchBar()

    let carData = ["Ford", "Mercedes", "Audi", "BMW", "Lamborghini", "Ferrari"]
    var filterdata: [String]!

    override func viewDidLoad() {
        super.viewDidLoad()
        filterdata = carData
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self

        setupUI()
    }

    func setupUI() {
        view.addSubview(searchBar)
        view.addSubview(tableView)

        searchBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }

        tableView.register(CityCell.self, forCellReuseIdentifier: CityCell.identifier)
    }
}

extension CitySearchViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterdata.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CityCell = tableView.dequeueReusableCell(withIdentifier: CityCell.identifier, for: indexPath) as! CityCell
        cell.label.text = filterdata[indexPath.row]
        return cell
    }
}

extension CitySearchViewController: UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterdata = []
        if searchText == ""
        {
            filterdata = carData
        }

        for word in carData
        {
            if word.uppercased().contains(searchText.uppercased())
            {
                filterdata.append(word)
            }
        }
        self.tableView.reloadData()
    }
}

