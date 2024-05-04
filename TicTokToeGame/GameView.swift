//
//  ContentView.swift
//  TicTokToeGame
//
//  Created by 中神和也 on 2024/04/02.
//

import SwiftUI
import Combine
import Foundation

// 丸バツゲーム画面
struct GameView: View {
    @EnvironmentObject var timerContorller: TimerModel
    @EnvironmentObject var gameModel : gameModel
    @StateObject var viewModel = GameViewModel()
    @State var winner : String = ""
    @State private var isGameSet : Bool = false
    @State var selections: [Bool?] = []
    
    var body: some View {
        let selectedMode = gameModel.selectedMode
        let columnSize = Int(pow(Double(selectedMode),Double(2)))
        if (viewModel.isGameSet){
            // どちらかが三つ並んで揃ったら結果画面に遷移
            ResultView(winnerUser: $winner,resultGrid: $selections)
        }else{
            // ゲーム画面
            ZStack {
                Color.blue
                    .ignoresSafeArea()
                VStack{
                    // ターンを表示
                    Text(timerContorller.isTurnEnd ? "⭕️の人のターン" : "❌の人のターン")
                        .font(.largeTitle)
                        .padding()
                    
                    // タイマーを表示　15秒過ぎたら自動的に相手ターンに移動
                    Text("\(timerContorller.count)")
                        .font(.system(size: 50))
                        .fontWeight(.bold)
                        .foregroundColor(Int(timerContorller.count) < 5 ? .red:.black)
                    
                    let columnSizeRange = 0..<columnSize //グリッドの範囲
                    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: selectedMode) // 3列のグリッドを作成するための設定
                    // 1辺100の正方形を並べる
                    LazyVGrid(columns: columns, spacing: 10){
                        ForEach(columnSizeRange){index in
                            if index < selections.count{
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
                                        // 未入力の四角形をタッチしたらマルかバツになり相手のターンになる
                                        if(selections[index] == nil){
                                            selections[index] = timerContorller.isTurnEnd
                                            // ３つ揃ったら勝ち
                                            if(viewModel.hasThreeInARow(grid: selections)){
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                                    winner = viewModel.hasFinidhedWin(currentPlayer: timerContorller.isTurnEnd)
                                                    timerContorller.stop()
                                                }
                                            }else{
                                                // 全てマス目が埋まったとしても勝負がついていなければ引き分けにする
                                                if(viewModel.isDraw(grid: selections)){
                                                    winner = viewModel.hasFinishedDraw()
                                                    timerContorller.stop()
                                                }else{
                                                    timerContorller.restart()
                                                }
                                            }
                                        }
                                    }
                            }
                        }
                    }
                }
            }
            // 画面切り替えと同時にタイマースタート
            .onAppear(){
                selections = Array(repeating: nil, count: columnSize)
                timerContorller.start()
            }
        }
    }
}

//#Preview {
//    ContentView()
//        .environmentObject(TimerModel())
//}

