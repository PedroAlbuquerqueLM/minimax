//
//  NewellAndSimonTactic.swift
//  TicTacToe
//
//  Copyright © 2017 Pedro Albuquerque. All rights reserved.
//

import Foundation

/** Represents a single aspect of Newell and Simon's Tic-tac-toe strategy. */
protocol NewellAndSimonTactic {
    func choosePositionForMark(mark: Mark, onGameBoard gameBoard: GameBoard) -> GameBoard.Position?
}
