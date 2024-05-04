//
//  CPUModel.swift
//  TicTokToeGame
//
//  Created by 中神和也 on 2024/04/09.
//

import SwiftUI
import Foundation
import Combine

/*CPUモデルクラス*/
class CPUModel: ObservableObject {
    
    // ランダムでマスを選択する
    func selecteGrid(grid:[Bool?]){
        // グリッドの中身を取得し、値が入っていない箇所に選択をする
        let emptyGrid = grid.indices.filter { grid[$0] == nil }
        if emptyGrid.isEmpty {return}
        
        let randomIndex = emptyGrid.randomElement()!
//        grid[randomIndex] = false
    }
}
