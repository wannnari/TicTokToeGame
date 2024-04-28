//
//  GameFunc.swift
//  TicTokToeGame
//
//  Created by 中神和也 on 2024/04/12.
//

import SwiftUI

// 勝利画面
struct ResultView: View {
    
    @State var isRestart : Bool = false
    @State var isMenu : Bool = false
    @Binding var winnerUser : String
    
    var body: some View {
        
        if isRestart{
            ContentView()
        }else if isMenu{
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
                    Button(action:{ isRestart.toggle()
                    }){
                        Text("もう一度")
                            .padding()
                            .font(.system(size: 50))
                            .foregroundColor(Color.white)
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    Button(action:{ isMenu.toggle()
                    }){
                        Text("スタート画面へ")
                            .padding()
                            .font(.system(size: 40))
                            .foregroundColor(Color.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
            }
        }
    }
}

//#Preview {
//    ResultView()
//}
