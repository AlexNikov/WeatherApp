//
//  ForecastView.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 31.07.2021.
//

import UIKit

protocol IForecastTabViewDelegate: AnyObject
{
	func willShow(cell: IForecastTabCell, index: Int)
	func numberOfRows() -> Int
}

protocol IForecastTabView: AnyObject
{
	var delegate: IForecastTabViewDelegate? { get set }

	func reloadData()
}

class ForecastTabView: UIView
{
	weak var delegate: IForecastTabViewDelegate?

	lazy var tableView = UITableView()

	private let reuseIdentifier = "ForecastTabCell"

	override init(frame: CGRect) {
		super.init(frame: frame)
		configureView()
	}

	@available(*, unavailable)
	public required init(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension ForecastTabView: IForecastTabView
{
	func reloadData() {
		tableView.reloadData()
	}
}

extension ForecastTabView: UITableViewDataSource
{
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return delegate?.numberOfRows() ?? 0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier,
												 for: indexPath) as! ForecastTabCell

		delegate?.willShow(cell: cell, index: indexPath.row)
		return cell
	}
}

extension ForecastTabView: UITableViewDelegate
{

}

private extension ForecastTabView
{
	func configureView() {
		backgroundColor = .white

		addSubview(tableView)

		tableView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: topAnchor),
			tableView.leftAnchor.constraint(equalTo: leftAnchor),
			tableView.rightAnchor.constraint(equalTo: rightAnchor),
			tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
		tableView.allowsSelection = false
		tableView.separatorInset = .zero
		tableView.dataSource = self
		tableView.delegate = self
		tableView.tableFooterView = UIView()
		tableView.register(ForecastTabCell.self, forCellReuseIdentifier: self.reuseIdentifier)
	}
}
