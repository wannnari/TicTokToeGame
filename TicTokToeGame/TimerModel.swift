//
//  TimerModel.swift
//  TicTokToeGame
//
//  Created by 中神和也 on 2024/04/07.
//

import SwiftUI
import Foundation
import Combine

/*タイマーモデルクラス*/
class TimerModel: ObservableObject {
    
    @Published var timer : Timer!
    @Published var count : Int = 0
    @Published var isTurnEnd : Bool = true
    @State private var STARTTIME : Int = 15
    
    //　タイマースタート
    func start(){
        self.timer?.invalidate()
        self.count = STARTTIME
        self.timer = Timer.scheduledTimer(withTimeInterval:1, repeats: true){_ in
            self.count -= 1
            // 0になったら強制終了
            if(self.count == 0){
                self.timer?.invalidate()
                self.timer = nil
                self.isTurnEnd.toggle()
                self.start()
                return
            }
        }
    }

    // タイマーリスタート（ターンが変わる）
    func restart(){
        timer?.invalidate()
        timer = nil
        self.isTurnEnd.toggle()
        self.start()
    }
    
    // タイマーストップ
    func stop(){
        timer?.invalidate()
        timer = nil
    }

}


