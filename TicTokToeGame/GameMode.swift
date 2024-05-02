//
//  GameMode.swift
//  TicTokToeGame
//
//  Created by 中神和也 on 2024/04/29.
//

import Foundation
import SwiftUI
import Combine

//ゲームモードの選択肢
struct Mode: Identifiable{
    var id : Int
    var mode : String
}


class gameModeModel : ObservableObject{
    
    let gameMode = [
        3 : "3×3",
        4 : "4×4",
        5 : "5×5"
    ]
    
    var gameModeList: [(key: Int, value: String)]{
        gameMode.map{($0.key,$0.value)}.sorted{$0.key < $1.key}
    }
    
    @Published var selectedMode : Int = 3
}


