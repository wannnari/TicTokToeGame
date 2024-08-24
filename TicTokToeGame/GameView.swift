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
    @ObservedObject var tictactoeModel : TicTacToeViewModel
    @State var selections: [Bool?] = []
    @State var isAllowTap : Bool = true
    var body: some View {
        let selectedSquaresMode = gameModel.selectedSquaresMode
        let selectedGameMode = gameModel.selectedGameMode
        let selectedVsMode = gameModel.selectedVsMode
        let columnSize = Int(pow(Double(selectedSquaresMode),Double(2)))

        if (tictactoeModel.isGameSet){
            // どちらかが三つ並んで揃ったら結果画面に遷移
            ResultView(winnerUser: $tictactoeModel.message,resultGrid: $tictactoeModel.board)
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
                    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: selectedSquaresMode) // 3列のグリッドを作成するための設定
                    // 1辺100の正方形を並べる
                    LazyVGrid(columns: columns, spacing: 10){
                        ForEach(columnSizeRange){index in
                            if index < selections.count{
                                Rectangle()
                                    .fill(Color.white)              // 図形の塗りつぶしに使うViewを指定
                                    .frame(width:100, height: 100)  // フレームサイズ指定
                                    .overlay(
                                        // 丸かバツを表示する
                                        Text(tictactoeModel.board[index] ?? false ? "⭕️" : "❌")
                                            .opacity(tictactoeModel.board[index] == nil ? 0 : 1 )
                                            .font(.largeTitle)
                                    )
                                    .allowsHitTesting(isAllowTap) //CPUのターン中はプレイヤーは行動できない
                                    .onTapGesture {
                                        // 未入力の四角形をタッチしたらマルかバツになり相手のターンになる
                                        if(tictactoeModel.board[index] == nil){
                                                tictactoeModel.makeMove(at:index, player: timerContorller.isTurnEnd, isRemoveMode: selectedGameMode, isVSCPU: selectedVsMode)
                                            
                                            // どちらかが先に3つ揃うか引き分けの場合には時計をストップさせる
                                            if(tictactoeModel.hasThreeInARow(grid: tictactoeModel.board)||tictactoeModel.isDraw(grid: tictactoeModel.board)){
                                                isAllowTap.toggle()
                                                timerContorller.stop()
                                            }else{
                                                timerContorller.restart()
                                                if(selectedVsMode == 2){
                                                    isAllowTap.toggle()
                                                    DispatchQueue.main.asyncAfter(deadline: .now()+3){
                                                        isAllowTap.toggle()
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
            }
            // 画面切り替えと同時にタイマースタート
            .onAppear(){
                selections = Array(repeating: nil, count: columnSize)
                isAllowTap = true
                timerContorller.start()
            }
        }
    }
}



//#Preview {
//    ContentView()
//        .environmentObject(TimerModel())
//}

