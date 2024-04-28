//
//  ContentView.swift
//  TicTokToeGame
//
//  Created by 中神和也 on 2024/04/02.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State private var selections: [Bool?] = Array(repeating: nil, count: 9)
    @State private var isGameSet : Bool = false
    @EnvironmentObject var timerContorller: TimerModel
    @State var winner : String = ""
    
    var body: some View {
        if (isGameSet){
            // どちらかが三つ並んで揃ったら結果画面に遷移
            ResultView(winnerUser: $winner)
        }else{
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
                                    // 未入力の四角形をタッチしたらマルかバツになり相手のターンになる
                                    if(selections[index] == nil){
                                        selections[index] = timerContorller.isTurnEnd
                                        
                                        // ３つ揃ったら勝ち
                                        if(hasThreeInARow(grid: selections)){
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                                isGameSet.toggle()
                                                winner = timerContorller.isTurnEnd ? "⭕️の人の勝利！" : "❌の人の勝利！"
                                                timerContorller.stop()
                                            }
                                        }else{
                                            // 全てマス目が埋まったとしても勝負がついていなければ引き分けにする
                                            for number in 0..<selections.count {
                                                if selections[number] == nil {
                                                    timerContorller.restart()
                                                    break
                                                }else if(number == selections.count-1){
                                                    if (selections[number] != nil){
                                                        isGameSet.toggle()
                                                        winner = "引き分け!!"
                                                        timerContorller.stop()
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
                timerContorller.start()
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(TimerModel())
}

// 三つ揃っているかチェック
func hasThreeInARow(grid: [Bool?]) -> Bool{
    let squareRoot = Int(sqrt(Double(grid.count)))
    var board = [[Bool?]](repeating: [Bool?](repeating: nil,count: squareRoot), count: squareRoot)
    var boardSizeCounter = 0
    for squareSide in 0..<squareRoot {
        for otherSide in 0..<squareRoot{
            board[squareSide][otherSide] = grid[boardSizeCounter]
            boardSizeCounter = boardSizeCounter + 1
        }
    }
    for row in 0..<squareRoot{
        if checkLineForThree(values: board[row]){
            return true
        }
    }
    // 縦のチェック
    for column in 0..<squareRoot {
        var columnValues: [Bool?] = []
        for row in 0..<squareRoot {
            columnValues.append(board[row][column])
        }
        if checkLineForThree(values: columnValues) {
            return true
        }
    }
    // 主対角線のチェック (\ direction)
    var diag1Values: [Bool?] = []
    for index in 0..<squareRoot {
        diag1Values.append(board[index][index])
    }
    if checkLineForThree(values: diag1Values) {
        return true
    }
    // 副対角線のチェック (/ direction)
    var diag2Values: [Bool?] = []
    for index in 0..<squareRoot {
        diag2Values.append(board[index][squareRoot - 1 - index])
    }
    if checkLineForThree(values: diag2Values) {
        return true
    }
    return false
}


func checkLineForThree(values:[Bool?]) -> Bool{
    var current = values[0]
    var count = 1
    
    for value in values[1...]{
        if value == current && value != nil {
            count += 1
            if count >= 3{return true}
        }else{
            current = value
            count = 1
        }
    }
    return false
}
