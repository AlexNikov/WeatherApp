//
//  LocalLanguageService.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 01.08.2021.
//

import Foundation

class LocalLanguageService
{
	private enum LangType: String
	{
		case ru
		case en
	}

	var languageCode: String = {
		guard let languageCode = NSLocale.current.languageCode,
			  let lang = LangType(rawValue: languageCode) else {
			return LangType.ru.rawValue
		}
		return lang.rawValue
	}()
}
