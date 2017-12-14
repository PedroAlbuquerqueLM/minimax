//
//  UserStrategy.swift
//  TicTacToeApp
//
//  Copyright © 2017 Pedro Albuquerque. All rights reserved.
//

import Foundation
import TicTacToe

/** A Tic-tac-toe strategy that allows a person to decide where to put marks on a game board. */
final class UserStrategy: TicTacToeStrategy {
    
    func choosePositionForMark(_: Mark, onGameBoard _: GameBoard, completionHandler: GameBoard.Position -> Void) {
        self.reportChosenPositionClosure = completionHandler
    }
    
    func reportChosenPosition(position: GameBoard.Position) {
        if let reportChosenPositionClosure = reportChosenPositionClosure {
            self.reportChosenPositionClosure = nil
            reportChosenPositionClosure(position)
        }
    }
    
    var isWaitingToReportChosenPosition: Bool {
        return reportChosenPositionClosure != nil
    }
    
    private var reportChosenPositionClosure: (GameBoard.Position -> Void)?
}
