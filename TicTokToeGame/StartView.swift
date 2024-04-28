//
//  StartView.swift
//  TicTokToeGame
//
//  Created by 中神和也 on 2024/04/02.
//

import SwiftUI

struct StartView: View {
    @State var isStart: Bool = false;
    @State var gameMode:[String] = ["3×3","4×4","5×5"]
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
            
            Picker(selection: $defaultMode, label: Text("マス目を選択"),content: {
                ForEach(gameMode, id:\.self){
                    value in Text("\(value)")
                        .tag(value)
                        .font(.system(size: 50))
                }
            })
            .pickerStyle(.menu)

            
        }
    }
}

#Preview {
    StartView()
}
