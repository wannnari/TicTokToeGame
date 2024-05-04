//
//  StartView.swift
//  TicTokToeGame
//
//  Created by 中神和也 on 2024/04/02.
//

import SwiftUI

struct StartView: View {
    @State var isStart: Bool = false;
    @EnvironmentObject var gameModel:gameModel
    
    var body: some View {
        if isStart {
            GameView()
                .environmentObject(TimerModel())
        }else{
            Text("⭕️❌ゲーム")
                .font(.system(size: 50))

            Button(action:{ isStart.toggle()
            }){
                Text("スタート")
                    .padding()
                    .font(.system(size: 50))
                    .foregroundColor(Color.white)
                    .background(Color.purple)
                    .cornerRadius(10)
            }
            
            Picker(selection: $gameModel.selectedMode, label: Text("マス目を選択"),content: {
                ForEach(gameModel.gameModeList, id: \.key){ mode in
                    Text("\(mode.value)")
                        .tag(mode.key)
                        .font(.system(size: 50))
                }
            })
            .pickerStyle(.menu)
        }
    }
}

//#Preview {
//    StartView()
//}
