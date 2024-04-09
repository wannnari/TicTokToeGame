//
//  ContentView.swift
//  TicTokToeGame
//
//  Created by 中神和也 on 2024/04/02.
//

import SwiftUI

struct ContentView: View {
    @State private var selections: [Bool?] = Array(repeating: nil, count: 9)
    @EnvironmentObject var timerContorller: TimerModel
    
    var body: some View {
        
        ZStack {
            Color.blue
                .ignoresSafeArea()
            VStack{
                Text(timerContorller.isTurnEnd ? "⭕️の人のターン" : "❌の人のターン")
                    .font(.largeTitle)
                    .padding()
                /*タイマーを表示　15秒過ぎたら自動的に相手ターンに移動*/
                Text("\(timerContorller.count)")
                    .font(.system(size: 50))
                    .fontWeight(.bold)
                    .foregroundColor(Int(timerContorller.count) < 5 ? .red:.black)
                
                // 3列のグリッドを作成するための設定
                let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
                
                // 1辺100の正方形を3×3で並べる
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
                            .onTapGesture {
                                // 　未入力の四角形をタッチしたらマルかバツになり相手のターンになる
                                if(selections[index] == nil){
                                    selections[index] = timerContorller.isTurnEnd
                                    timerContorller.restart()
                                }
                            }
                    }
                }
            }
        }
        // 画面切り替えと同時にタイマースタート
        .onAppear(){
            timerContorller.start()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(TimerModel())
}
