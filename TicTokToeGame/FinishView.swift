//
//  FinishView.swift
//  TicTokToeGame
//
//  Created by 中神和也 on 2024/05/03.
//

import Foundation
import SwiftUI

// 結果画面を表示
struct FinishView: View {
    @Binding var finishGrid: [Bool?]
    @EnvironmentObject var gameModel : gameModel
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            VStack{
                let columnSizeRange = 0..<finishGrid.count //グリッドの範囲
                let selectedMode = gameModel.selectedMode
                let columns: [GridItem] = Array(repeating: .init(.flexible()), count:selectedMode) // 3列のグリッドを作成するための設定
                LazyVGrid(columns: columns, spacing: 10){
                    ForEach(columnSizeRange){index in
                        if index < finishGrid.count{
                            Rectangle()
                                .fill(Color.white)              // 図形の塗りつぶしに使うViewを指定
                                .frame(width:100, height: 100)  // フレームサイズ指定
                                .overlay(
                                    // 丸かバツを表示する
                                    Text(finishGrid[index] ?? false ? "⭕️" : "❌")
                                        .opacity(finishGrid[index] == nil ? 0 : 1 )
                                        .font(.largeTitle)
                                )
                        }
                    }
                }
            }
        }
    }
}

//#Preview {
//    FinishView()
//}
