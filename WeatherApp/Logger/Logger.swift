//
//  Logger.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 01.08.2021.
//

import Foundation

enum LogType: String
{
	case debug
	case error

	var emoji: String {
		switch self {
		case .debug:
			return "⚙️"
		case .error:
			return "⛔️"
		}
	}
}

enum Logger
{
	static func debug(_ message: String,
					  _ file: StaticString = #file,
					  _ function: StaticString = #function,
					  _ line: UInt = #line) {
		let callPoint = self.callPoint(file: file, function: function, line: line)
		Logger.log(.debug, message: message, callPoint: callPoint)
	}

	static func error(_ message: String,
					  _ file: StaticString = #file,
					  _ function: StaticString = #function,
					  _ line: UInt = #line) {
		let callPoint = self.callPoint(file: file, function: function, line: line)
		Logger.log(.error, message: message, callPoint: callPoint)
	}
}

private extension Logger
{
	static func callPoint(file: StaticString, function: StaticString, line: UInt) -> String {
		let fileNameWithExtension = URL(fileURLWithPath: "\(file)").lastPathComponent
		return "\(fileNameWithExtension): \(function). line:\(line)"
	}

	static func log(_ logType: LogType,
					message: String,
					callPoint: String) {

		let fullMessage = "\(logType.emoji) \(logType.rawValue). \(callPoint):\n\(message)\n"

		print(fullMessage)
	}
}
