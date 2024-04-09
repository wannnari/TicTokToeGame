//
//  StartView.swift
//  TicTokToeGame
//
//  Created by 中神和也 on 2024/04/02.
//

import SwiftUI

struct StartView: View {
    @State var isStart: Bool = false;
    var body: some View {
 

        if isStart {
            ContentView()
                .environmentObject(TimerModel())
        }else{
            Text("⭕️❌ゲーム")
                .font(.system(size: 50))
            Button("スタート"){
                isStart.toggle()
            }
            .padding()
            .font(.system(size: 50))
        }
    }
}

#Preview {
    StartView()
}
