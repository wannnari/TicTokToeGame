//
//  ContentView.swift
//  TicTokToeGame
//
//  Created by 中神和也 on 2024/04/02.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State private var selections: [Bool?] = Array(repeating: nil, count: 16)
    @State private var isGameSet : Bool = false
    @EnvironmentObject var timerContorller: TimerModel
    
    var body: some View {
        if (isGameSet){
            // どちらかが三つ並んで揃ったら結果画面に遷移
            ResultView()
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
                    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)
                    // 1辺100の正方形を3×3で並べる
                    LazyVGrid(columns: columns, spacing: 10){
                        ForEach(0..<16){index in
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
                                                timerContorller.stop()
                                            }
                                        }else{
                                            timerContorller.restart()
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


// 三つ揃ったかの判定処理
//func isLineOfThrees(grid: [Bool?]) -> Bool{
//    var squareRoot = Int(sqrt(Double(grid.count)))
//    var board = [[Bool?]](repeating: [Bool?](repeating: nil,count: squareRoot), count: squareRoot)
////    var board: [[Bool?]] = [[nil,nil,nil],[nil,nil,nil],[nil,nil,nil]]
////    board[0][0] = grid[0]
////    board[0][1] = grid[1]
////    board[0][2] = grid[2]
////    board[1][0] = grid[3]
////    board[1][1] = grid[4]
////    board[1][2] = grid[5]
////    board[2][0] = grid[6]
////    board[2][1] = grid[7]
////    board[2][2] = grid[8]
//    let boardSize = squareRoot
//    var boardSizeCounter = 0
//    for squareSide in 0..<squareRoot {
//        for otherSide in 0..<squareRoot{
//            board[squareSide][otherSide] = grid[boardSizeCounter]
//            boardSizeCounter = boardSizeCounter + 1
//        }
//    }

//    // 横のチェック
//    for row in 0..<boardSize {
//        if board[row][0] != nil, board[row][0] == board[row][1], board[row][1] == board[row][2] {
//            return true
//        }
//    }
//    if isBesideArrange(arr: board){
//        return true
//    }
//    // 縦のチェック
//    for column in 0..<boardSize {
//        if board[0][column] != nil, board[0][column] == board[1][column], board[1][column] == board[2][column] {
//            return true
//        }
//    }
//    if isVerticalArrange(arr: board){
//        return true
//    }
//
//    // 斜めのチェック
//    if board[0][0] != nil, board[0][0] == board[1][1], board[1][1] == board[2][2] {
//        return true
//    }
//    if board[0][2] != nil, board[0][2] == board[1][1], board[1][1] == board[2][0] {
//        return true
//    }
//    if isDiagonalArrange(arr: board){
//        return true
//    }
//

//    if hasThreeInARow(board: board){
//        return true
//    }else{
//        return false
//    }
//    return false
//}


#Preview {
    ContentView()
        .environmentObject(TimerModel())
}

func hasThreeInARow(grid: [Bool?]) -> Bool{
    var squareRoot = Int(sqrt(Double(grid.count)))
    var board = [[Bool?]](repeating: [Bool?](repeating: nil,count: squareRoot), count: squareRoot)
    let boardSize = squareRoot
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
