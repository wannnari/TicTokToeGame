//
//  GameViewModel.swift
//  TicTokToeGame
//
//  Created by 中神和也 on 2024/05/04.
//

import Foundation

class GameViewModel:ObservableObject{
    
    @Published var isGameSet = false
    
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
    
    // 勝利者のコメントとゲーム終了へ遷移するフラグを立てる
    func hasFinidhedWin(currentPlayer: Bool) -> String{
        let winner = currentPlayer ? "⭕️の人の勝利！" : "❌の人の勝利！"
        self.isGameSet.toggle()
        return winner
    }
    
    //　引き分け時のコメントとゲーム終了へ遷移するフラグを立てる
    func hasFinishedDraw() -> String{
        self.isGameSet.toggle()
        return "引き分け!!"
    }
}
