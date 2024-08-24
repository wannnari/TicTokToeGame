//
//  StartView.swift
//  TicTokToeGame
//
//  Created by 中神和也 on 2024/04/02.
//

import SwiftUI

struct StartView: View {
    @State var isStart: Bool = false
    @EnvironmentObject var gameModel:gameModel
    
    var body: some View {
        if isStart {
            GameView(tictactoeModel: TicTacToeViewModel(boardSize: gameModel.selectedSquaresMode))
                .environmentObject(TimerModel())
        }else{
            VStack{
                Text("⭕️❌ゲーム")
                    .font(.system(size: 50))
                VStack(alignment:.leading){
                    HStack{
                        Text("マス目")
                        Spacer()
                        Picker(selection: $gameModel.selectedSquaresMode, label: Text("マス目を選択"),content: {
                            ForEach(gameModel.squaresModeList, id: \.key){ mode in
                                Text("\(mode.value)")
                                    .tag(mode.key)
                                    .font(.system(size: 50))
                            }
                        })
                        .pickerStyle(.menu)
                    }
                    HStack{
                        Text("ゲーム形式")
                        Spacer()
                        Picker(selection: $gameModel.selectedGameMode, label: Text("ゲーム形式を選択"),content: {
                            ForEach(gameModel.gameModeList, id: \.key){ mode in
                                Text("\(mode.value)")
                                    .tag(mode.key)
                                    .font(.system(size: 30))
                            }
                        })
                        .pickerStyle(.menu)
                    }
                    HStack{
                        Text("対戦モード")
                        Spacer()
                        Picker(selection: $gameModel.selectedVsMode, label: Text("対戦モードを選択"),content: {
                            ForEach(gameModel.vsModeList, id: \.key){ mode in
                                Text("\(mode.value)")
                                    .tag(mode.key)
                                    .font(.system(size: 50))
                            }
                        })
                        .pickerStyle(.menu)
                    }
                }
                .padding(70)
                
                Button(action:{
                    isStart.toggle()
                },label:{
                    Text("スタート")
                        .padding()
                        .font(.system(size: 40))
                        .foregroundColor(Color.white)
                        .background(Color.purple)
                        .cornerRadius(10)
                })
            }
        }
    }
}




//#Preview {
//    StartView()
//}
