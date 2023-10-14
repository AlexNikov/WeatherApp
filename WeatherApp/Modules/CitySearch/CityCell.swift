//
//  CityCell.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 14.10.2023.
//

import UIKit
import SnapKit

final class CityCell: UITableViewCell {
    let label = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("Please use this class from code.")
    }

    func setupUI() {
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(52)
        }
    }
}
