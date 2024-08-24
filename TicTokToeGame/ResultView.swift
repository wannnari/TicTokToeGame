//
//  GameFunc.swift
//  TicTokToeGame
//
//  Created by 中神和也 on 2024/04/12.
//

import SwiftUI

// 勝利画面
struct ResultView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var gameModel : gameModel
    @State var isRestart : Bool = false
    @State var isMenu : Bool = false
    @State var isFinish : Bool = false
    @Binding var winnerUser : String
    @Binding var resultGrid : [Bool?]
    
    var body: some View {
        
        if isRestart{
            // 対戦画面
            GameView(tictactoeModel: TicTacToeViewModel(boardSize: gameModel.selectedSquaresMode))
        }else if isMenu{
            // ホーム画面
            StartView()
        }else{
            ZStack{
                Color.yellow
                VStack{
                    // 勝負がついた場合は勝利した人の名を表示
                    // 引き分けの場合は引き分けと表示
                    Text(winnerUser)
                        .font(.system(size:55))
                        .foregroundColor(Color.red)
                    Button(action:{ 
                        isRestart.toggle()
                    },label: {
                        Text("もう一度")
                            .padding()
                            .font(.system(size: 50))
                            .foregroundColor(Color.white)
                            .background(Color.green)
                            .cornerRadius(10)
                    })
                    Button(action:{ 
                        isMenu.toggle()
                    },label:{
                        Text("スタート画面へ")
                            .padding()
                            .font(.system(size: 40))
                            .foregroundColor(Color.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    })
                    Button(action:{
                        isFinish.toggle()
                    },label:{
                        Text("ゲーム終了時の盤面を見る")
                            .padding()
                            .font(.system(size: 40))
                            .foregroundColor(Color.white)
                            .background(Color.gray)
                            .cornerRadius(10)
                    })

                    
                    .sheet(isPresented: $isFinish){
                        FinishView(finishGrid: $resultGrid)
                    }
                }
            }
        }
    }
}

//#Preview {
//    ResultView()
//}
