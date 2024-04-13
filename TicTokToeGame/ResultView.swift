//
//  GameFunc.swift
//  TicTokToeGame
//
//  Created by 中神和也 on 2024/04/12.
//

import Foundation

//// 三つ揃ったかの判定処理
//func isLineOfThrees(board: [[String]]) -> Bool{
//    let boardSize = board[0].count
//    for column in 0..<boardSize{
//        var columnSet = Set<String>()
//        for row in 0..<boardSize{
//            columnSet.insert(board[row][column])
//        }
//        if columnSet.count == 1 && !columnSet.contains(" "){
//            return true
//        }
//    }
//    return false
//}
