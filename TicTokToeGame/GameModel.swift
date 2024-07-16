//
//  GameMode.swift
//  TicTokToeGame
//
//  Created by 中神和也 on 2024/04/29.
//

import Foundation
import SwiftUI
import Combine

//ゲームクラス
class gameModel : ObservableObject{

    //遊ぶマス目の選択肢
    let squaresMode = [
        3 : "3×3",
        4 : "4×4",
        5 : "5×5"
    ]
        
    var squaresModeList: [(key: Int, value: String)]{
        squaresMode.map{($0.key,$0.value)}.sorted{$0.key < $1.key}
    }
    
    @Published var selectedSquaresMode : Int = 3
    
    //ゲームモードの選択肢
    let gameMode = [
        1 : "引き分けあり",
        2 : "勝負がつくまでエンドレス！"
    ]
    
    var gameModeList: [(key: Int, value: String)]{
        gameMode.map{($0.key,$0.value)}.sorted{$0.key < $1.key}
    }
    
    @Published var selectedGameMode : Int = 3
}


