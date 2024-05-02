//
//  StartView.swift
//  TicTokToeGame
//
//  Created by 中神和也 on 2024/04/02.
//

import SwiftUI

struct StartView: View {
    @State var isStart: Bool = false;
    @EnvironmentObject var gameMode:gameModeModel
//    @State var gameMode:[String: Int] = ["3×3":3,"4×4":4,"5×5":5]
    @State var defaultMode:String = "3×3"
    var body: some View {
 

        if isStart {
            ContentView()
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
            
            Picker(selection: $gameMode.selectedMode, label: Text("マス目を選択"),content: {
                ForEach(gameMode.gameModeList, id: \.key){ mode in
                    Text("\(mode.value)")
                        .tag(mode.key)
                        .font(.system(size: 50))
                }
//                ForEach(gameMode, id:\.self){
//                    mode in Text("\(mode)")
//                        .tag(mode)
//                        .font(.system(size: 50))
//                }
            })
            .pickerStyle(.menu)

            
        }
    }
}

//#Preview {
//    StartView()
//}
