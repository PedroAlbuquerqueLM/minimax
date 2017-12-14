//
//  GameBoardView.swift
//  TicTacToeApp
//
//  Copyright © 2017 Pedro Albuquerque. All rights reserved.
//

import TicTacToe
import UIKit

/** Displays the lines and marks of a Tic-tac-toe game. */
final class GameBoardView: UIView {
    
    var gameBoard: GameBoard? {
        didSet {
            _layout = nil
            _renderer = nil
            winningPositions = nil
        }
    }
    
    var winningPositions: [GameBoard.Position]? {
        didSet { refreshBoardState() }
    }
    
    func refreshBoardState() {
        setNeedsDisplay()
    }
    
    var tappedEmptyPositionHandler: (GameBoard.Position -> Void)?
    
    var tappedFinishedGameBoardHandler: (Void -> Void)?
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        
        if gameBoard != nil {
            handleTouchesEnded(touches)
        }
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        if gameBoard != nil {
            renderer.renderWithWinningPositions(winningPositions)
        }
    }
    
    private var _renderer: GameBoardRenderer?
    private var renderer: GameBoardRenderer {
        assert(gameBoard != nil)
        if _renderer == nil {
            // By the time a renderer is needed, this view's graphics context should exist.
            let context = UIGraphicsGetCurrentContext()!
            _renderer = GameBoardRenderer(context: context, gameBoard: gameBoard!, layout: layout)
        }
        return _renderer!
    }
    
    private var _layout: GameBoardLayout?
    private var layout: GameBoardLayout {
        assert(gameBoard != nil)
        if _layout == nil {
            // By the time a layout is needed, this view's frame should reflect its actual size.
            _layout = GameBoardLayout(frame: frame, marksPerAxis: gameBoard!.dimension)
        }
        return _layout!
    }
}



// MARK: - Touch handling

private extension GameBoardView {
    func handleTouchesEnded(touches: Set<UITouch>) {
        if isGameFinished {
            reportTapOnFinishedGameBoard()
        }
        else if let touch = touches.first, emptyPosition = emptyPositionFromTouch(touch) {
            reportTapOnEmptyPosition(emptyPosition)
        }
    }
    
    var isGameFinished: Bool {
        let
        wasWon  = winningPositions != nil,
        wasTied = gameBoard?.emptyPositions.count == 0
        return wasWon || wasTied
    }
    
    func emptyPositionFromTouch(touch: UITouch) -> GameBoard.Position? {
        guard let gameBoard = gameBoard else { return nil }
        
        let
        touchLocation  = touch.locationInView(self),
        emptyPositions = gameBoard.emptyPositions,
        emptyCellRects = layout.cellRectsAtPositions(emptyPositions)
        
        return zip(emptyPositions, emptyCellRects)
            .flatMap { (position, cellRect) in cellRect.contains(touchLocation) ? position : nil }
            .first
    }
    
    func reportTapOnFinishedGameBoard() {
        guard let tappedFinishedGameBoardHandler = tappedFinishedGameBoardHandler else { return }
        tappedFinishedGameBoardHandler()
    }
    
    func reportTapOnEmptyPosition(position: GameBoard.Position) {
        guard let tappedEmptyPositionHandler = tappedEmptyPositionHandler else { return }
        tappedEmptyPositionHandler(position)
    }
}
