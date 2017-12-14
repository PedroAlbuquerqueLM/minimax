//
//  CenterTacticTests.swift
//  TicTacToe
//
//  Copyright © 2017 Pedro Albuquerque. All rights reserved.
//

import XCTest

class CenterTacticTests: XCTestCase {

    func test_choosePositionForMark_centerIsNotEmpty_returnsNil() {
        XCTAssertNil(CenterTactic().choosePositionForMark(.O, onGameBoard: board3x3(
            "   ",
            " X ",
            "   ")))
    }
    
    func test_choosePositionForMark_centerIsEmpty_returnsCenter() {
        let position = (CenterTactic().choosePositionForMark(.X, onGameBoard: board3x3(
            "   ",
            "   ",
            "   ")))
        if let position = position {
            XCTAssertTrue(position == (row: 1, column: 1))
        }
        else {
            XCTFail("Did not detect that the center is empty.")
        }
    }
}
