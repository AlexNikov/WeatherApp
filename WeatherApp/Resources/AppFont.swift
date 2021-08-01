//
//  AppFont.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 01.08.2021.
//

import UIKit

enum AppFont {
	case title1Header
	case title1Text
	case title2Text
	case bodyText
	case footnoteText

	var font: UIFont {
		switch self {
		case .title1Header:
			return UIFont.systemFont(ofSize: 34, weight: .bold)
		case .title1Text:
			return UIFont.systemFont(ofSize: 34, weight: .medium)
		case .title2Text:
			return UIFont.systemFont(ofSize: 22, weight: .regular)
		case .bodyText:
			return UIFont.systemFont(ofSize: 17, weight: .regular)
		case .footnoteText:
			return UIFont.systemFont(ofSize: 13, weight: .regular)
		}
	}
}
