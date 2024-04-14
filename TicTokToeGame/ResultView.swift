//
//  GameFunc.swift
//  TicTokToeGame
//
//  Created by 中神和也 on 2024/04/12.
//

import SwiftUI

// 勝利画面
struct ResultView: View {
    
    var body: some View {
        ZStack{
            Color.yellow
            Text("Winner")
                .font(.system(size:100))
                .foregroundColor(Color.red)
        }
    }
}

#Preview {
    ResultView()
}
