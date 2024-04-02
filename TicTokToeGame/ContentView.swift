//
//  ContentView.swift
//  TicTokToeGame
//
//  Created by 中神和也 on 2024/04/02.
//

import SwiftUI

struct ContentView: View {
    @State private var isChecked = false
    
    var body: some View {
        
        Text("マルバツゲーム")
            .font(.system(size: 30))
        ZStack {
            Color.blue
                 .ignoresSafeArea()
            // 1辺100の正方形を3×3で並べる
            VStack{
                HStack{
                    Rectangle()
//                        .fill(Color.white)               // 図形の塗りつぶしに使うViewを指定
                        .foregroundColor(isChecked ? .white : .black)
                        .frame(width:100, height: 100)  // フレームサイズ指定
                        .onTapGesture {
                            self.isChecked.toggle()
                        }
                    Rectangle()
//                        .fill(Color.white)               // 図形の塗りつぶしに使うViewを指定
                        .foregroundColor(isChecked ? .white : .black)
                        .frame(width:100, height: 100)  // フレームサイズ指定
                        .onTapGesture {
                            self.isChecked.toggle()
                        }
                    Rectangle()
//                        .fill(Color.white)               // 図形の塗りつぶしに使うViewを指定
                        .foregroundColor(isChecked ? .white : .black)
                        .frame(width:100, height: 100)  // フレームサイズ指定
                        .onTapGesture {
                            self.isChecked.toggle()
                        }
                }
                HStack{
                    Rectangle()
                        .fill(Color.white)               // 図形の塗りつぶしに使うViewを指定
                        .frame(width:100, height: 100)  // フレームサイズ指定
                    Rectangle()
                        .fill(Color.white)               // 図形の塗りつぶしに使うViewを指定
                        .frame(width:100, height: 100)  // フレームサイズ指定
                    Rectangle()
                        .fill(Color.white)               // 図形の塗りつぶしに使うViewを指定
                        .frame(width:100, height: 100)  // フレームサイズ指定
                }
                HStack{
                    Rectangle()
                        .fill(Color.white)               // 図形の塗りつぶしに使うViewを指定
                        .frame(width:100, height: 100)  // フレームサイズ指定
                    Rectangle()
                        .fill(Color.white)               // 図形の塗りつぶしに使うViewを指定
                        .frame(width:100, height: 100)  // フレームサイズ指定
                    Rectangle()
                        .fill(Color.white)               // 図形の塗りつぶしに使うViewを指定
                        .frame(width:100, height: 100)  // フレームサイズ指定
                }
            }
        }

    }
}

#Preview {
    ContentView()
}
