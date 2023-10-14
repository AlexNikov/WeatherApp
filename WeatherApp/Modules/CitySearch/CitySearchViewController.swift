//
//  CitySearchViewController.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 31.07.2021.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class CitySearchViewController: UIViewController {

	var updateCityHandler: MainTabUpdateCityCompletion?
    private let tableView = UITableView()
    private let searchBar = UISearchBar()

    private let disposeBag = DisposeBag()

    private let geoService = GeoService()

    private var data: [GeoResponse] = []
    private var loading: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        setupUI()
        setupBinding()
    }

    func setupBinding() {
        searchBar.rx.text
            .throttle(DispatchTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(with: self) { owner, query in
                owner.loading = true
                owner.geoService
                    .getCity(with: .init(q: query ?? ""))
                    .subscribe(
                        with: owner,
                        onNext: { owner, response in
                            owner.data = response
                            owner.loading = false
                            owner.tableView.reloadData()
                        },
                        onError: { owner, error in
                            owner.loading = false
                        })
                    .disposed(by: owner.disposeBag)
            }
            .disposed(by: disposeBag)

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
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item: GeoResponse = data[indexPath.item]
        let cell: CityCell = tableView.dequeueReusableCell(withIdentifier: CityCell.identifier, for: indexPath) as! CityCell
        cell.label.text = "\(item.country ?? "")-\(item.state ?? "")-\(item.localNames?.ru ?? "")"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard loading == false else { return }

        let item: GeoResponse = data[indexPath.item]
        let cityInfo = CityInfo(name: item.localNames?.ru ?? item.state ?? item.country ?? "",
                                location: Location(longitude: item.lon ?? 0,
                                                   latitude: item.lat ?? 0))
        updateCityHandler?(cityInfo)
        dismiss(animated: true, completion: nil)
    }

}

