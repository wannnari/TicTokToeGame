//
//  TicTacToeModel.swift
//  TicTokToeGame
//
//  Created by 中神和也 on 2024/07/16.
//

import Foundation
import SwiftUI
import Combine

struct Move {
        var index: Int    // セルのインデックス
        var player: Bool  // 'X' または 'O'
        var timestamp: Date  // この動きがいつ行われたかを記録
}

class TicTacToeViewModel: ObservableObject {
    @Published var board: [Bool?] = Array(repeating: nil, count: 9)
    @Published var moves: [Move] = []
    @Published var isGameSet = false
    @Published var message : String = ""
    let boardSize: Int
    let maxMove : Int = 3
    
    init(boardSize: Int = 3) {
        self.boardSize = boardSize
        self.board = Array(repeating: nil, count: boardSize * boardSize)
    }

    // マス目に丸バツを入れる処理
    func makeMove(at index: Int, player: Bool, isRemoveMode: Int, isVSCPU: Int){
        guard board[index] == nil else { return }

        let newMove = Move(index: index, player: player, timestamp: Date())
        moves.append(newMove)
        board[index] = player
        
        if(isRemoveMode == 2){
            if moves.filter({ $0.player == player }).count > maxMove {
                removeOldestMove(for: player)
            }
        }
        
        if(hasThreeInARow(grid: board) || isDraw(grid: board)){
            message = displayFinishedMessage(player: player)
            DispatchQueue.main.asyncAfter(deadline: .now()+3){
                self.isGameSet = true
                return
            }
        }else if(isVSCPU == 2){
            var cpuPlayer = player
            cpuPlayer.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now()+3){
                self.cpuMove(player: cpuPlayer, isRemoveMode: isRemoveMode)
            }
        }
        return
    }
    
    //CPU対戦モードの場合の処理
    func cpuMove(player: Bool, isRemoveMode:Int){
        var randomBoard : [Int] = []
        // 空のマスを検索
        for searchBoard in 0..<boardSize*boardSize{
            if board[searchBoard] == nil{
                randomBoard.append(searchBoard)
            }
        }

        // 空のマスからランダムで生成
        let moveBoard = randomBoard.randomElement()
        var index : Int!
        if moveBoard != nil {
            index = moveBoard
        } else {
            return
        }
        let newMove = Move(index: index, player: player, timestamp: Date())
        
        moves.append(newMove)
        board[index] = player
        
        if(isRemoveMode == 2){
            if moves.filter({ $0.player == player }).count > maxMove {
                removeOldestMove(for: player)
            }
        }
        
        if(hasThreeInARow(grid: board) || isDraw(grid: board)){
            message = displayFinishedMessage(player: player)
            DispatchQueue.main.asyncAfter(deadline: .now()+3){
                self.isGameSet = true
                return
            }
        }
        return
        
    }
    
    // 一番古いマスを消す処理
    private func removeOldestMove(for player: Bool) {
        if let oldestMove = moves.filter({ $0.player == player }).min(by: { $0.timestamp < $1.timestamp }) {
            board[oldestMove.index] = nil
            moves.removeAll(where: { $0.index == oldestMove.index })
        }
    }

    /*               *
     *　判定処理　開始  *
     *               */
    // 縦、横、斜めのどこかで三つ揃っているかをチェック
    func hasThreeInARow(grid: [Bool?]) -> Bool{
        let squareRoot = Int(sqrt(Double(grid.count)))
        var board = [[Bool?]](repeating: [Bool?](repeating: nil,count: squareRoot), count: squareRoot)
        var boardSizeCounter = 0
        for squareSide in 0..<squareRoot {
            for otherSide in 0..<squareRoot{
                board[squareSide][otherSide] = grid[boardSizeCounter]
                boardSizeCounter = boardSizeCounter + 1
            }
        }
        for row in 0..<squareRoot{
            if checkLineForThree(values: board[row]){
                return true
            }
        }
        // 縦のチェック
        for column in 0..<squareRoot {
            var columnValues: [Bool?] = []
            for row in 0..<squareRoot {
                columnValues.append(board[row][column])
            }
            if checkLineForThree(values: columnValues) {
                return true
            }
        }
        // 主対角線のチェック (\ direction)
        var diag1Values: [Bool?] = []
        for index in 0..<squareRoot {
            diag1Values.append(board[index][index])
        }
        if checkLineForThree(values: diag1Values) {
            return true
        }
        // 副対角線のチェック (/ direction)
        var diag2Values: [Bool?] = []
        for index in 0..<squareRoot {
            diag2Values.append(board[index][squareRoot - 1 - index])
        }
        if checkLineForThree(values: diag2Values) {
            return true
        }
        return false
    }

    // 指定された方向で3つ揃っているかチェック
    func checkLineForThree(values:[Bool?]) -> Bool{
        var current = values[0]
        var count = 1
        
        for value in values[1...]{
            if value == current && value != nil {
                count += 1
                if count >= 3{return true}
            }else{
                current = value
                count = 1
            }
        }
        return false
    }
    
    // 引き分けの判定を行う
    func isDraw(grid: [Bool?]) -> Bool{
        for number in 0..<grid.count {
            // 一つでもマスが埋まっていない場合には試合続行
            if grid[number] == nil {
                return false
            }
            // 全て埋まっている場合には引き分けの判定を行う
            if(number == grid.count-1 && grid[number] != nil){
                return true
            }
        }
        return false
    }
    
    // ゲーム終了のメッセージを入れる
    func displayFinishedMessage(player: Bool) -> String{
        var message : String = ""
        if(isDraw(grid: board)){
            message = hasFinishedDraw()
        }else{
            message = hasFinishedWin(currentPlayer: player)
        }
        return message
    }
    
    // 勝利者のコメントとゲーム終了へ遷移するフラグを立てる
    private func hasFinishedWin(currentPlayer: Bool) -> String{
        let winner = currentPlayer ? "⭕️の人の勝利！" : "❌の人の勝利！"
//        self.isGameSet.toggle()
        return winner
    }
    
    //　引き分け時のコメントとゲーム終了へ遷移するフラグを立てる
    private func hasFinishedDraw() -> String{
//        self.isGameSet.toggle()
        return "引き分け!!"
    }
    
    /*               *
     *　判定処理　終了  *
     *               */
}

