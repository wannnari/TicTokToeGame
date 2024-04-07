//
//  ContentView.swift
//  TicTokToeGame
//
//  Created by 中神和也 on 2024/04/02.
//

import SwiftUI

struct ContentView: View {
    @State private var isChecked = false
    @State private var selections: [Bool?] = Array(repeating: nil, count: 9)
    
    var body: some View {
        
        Text("マルバツゲーム")
            .font(.system(size: 30))
        VStack{
            ZStack {
                Color.blue
                    .ignoresSafeArea()
                // 1辺100の正方形を3×3で並べる
                VStack{
                    // 3列のグリッドを作成するための設定
                    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
                    Text(isChecked ? "⭕️の人のターン" : "❌の人のターン")
                        .font(.largeTitle)
                    
                    //3*3の正方形を作成
                    LazyVGrid(columns: columns, spacing: 10){
                        ForEach(0..<9){index in
                            Rectangle()
                                .fill(Color.white)              // 図形の塗りつぶしに使うViewを指定
                                .frame(width:100, height: 100)  // フレームサイズ指定
                                .overlay(
                                    // 丸かバツを表示する
                                    Text(selections[index] ?? false ? "⭕️" : "❌")
                                        .opacity(selections[index] == nil ? 0 : 1 )
                                        .font(.largeTitle)
                                )
                                // 四角形をタッチしたらマルかバツになり相手のターンになる
                                .onTapGesture {
                                    selections[index] = isChecked
                                    isChecked.toggle()
                                }
                            
                        }
                    }
                }
            }
            
        }
    }
}

#Preview {
    ContentView()
}
