//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Алексей Молокович on 15.10.2023.
//

import XCTest
import SnapshotTesting
import KIF
@testable import WeatherApp

extension XCTestCase {
    func viewTester(_ file : String = #file, _ line : Int = #line) -> KIFUIViewTestActor {
        return KIFUIViewTestActor(inFile: file, atLine: line, delegate: self)
    }

    func system(_ file : String = #file, _ line : Int = #line) -> KIFSystemTestActor {
        return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
    }
}

class SimpleSwiftTest: KIFTestCase {

    func testGreenCellWithIdentifier() {
        isRecording = true
        UIView.setAnimationsEnabled(false)
        let mainTab = viewTester().usingIdentifier(MainTabAccessibility.content.rawValue).waitForView()
        viewTester().usingIdentifier(MainTabAccessibility.cityNameLabel.rawValue).waitForView()
//        var labelArray = getAllAccessibilityLabelInWindows()
//        print("labelArray = \(labelArray)")

        viewTester().usingIdentifier(MainTabAccessibility.settingItem.rawValue).tap()

        viewTester().usingLabel(CitySearchAccessibility.searchBar.rawValue).waitForTappableView()
        viewTester().usingLabel(CitySearchAccessibility.searchBar.rawValue).tap()
        viewTester().usingLabel(CitySearchAccessibility.searchBar.rawValue).waitToBecomeFirstResponder()
        viewTester().usingLabel(CitySearchAccessibility.searchBar.rawValue).enterText("Kazan")

        let cell = viewTester().usingLabel("RU-Tatarstan-Казань").waitForTappableView()


        viewTester().usingLabel("RU-Tatarstan-Казань").tap()
        checkSnapshot(of: mainTab!, as: .image, snapshotDirectory: "test", testName: "1")
        checkSnapshot(of: cell!, as: .image, snapshotDirectory: "test",testName: "cell")
    }

    func getAllAccessibilityLabel(_ viewRoot: UIView) -> [String]! {

        var array = [String]()
        for view in viewRoot.subviews {
            if let lbl = view.accessibilityLabel {
                array += [lbl]
            }

            array += getAllAccessibilityLabel(view)
        }

        return array
    }

    func getAllAccessibilityLabelInWindows() -> [String]! {
        var labelArray = [String]()
        for  window in UIApplication.shared.windows {
            labelArray += self.getAllAccessibilityLabel(window)
        }

        return labelArray
    }

    func checkSnapshot<Value, Format>(
        of value: @autoclosure () throws -> Value,
        as snapshotting: Snapshotting<Value, Format>,
        named name: String? = nil,
        record recording: Bool = false,
        snapshotDirectory: String? = nil,
        timeout: TimeInterval = 5,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line
    ) {
        let failure = verifySnapshot(
            of: try value(),
            as: snapshotting,
            named: name,
            record: recording,
            snapshotDirectory: snapshotDirectory,
            timeout: timeout,
            file: file,
            testName: testName,
            line: line
        )
        guard let message = failure, isRecording == false else { return }
        XCTFail(message, file: file, line: line)
    }
}
