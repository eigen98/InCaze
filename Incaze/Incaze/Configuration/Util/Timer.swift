//
//  Timer.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/19.
//

import Foundation
import Combine


class RunTimer{

    let timer = Timer.TimerPublisher(interval: 1.0, runLoop: .main, mode: .default)
    private var cancellable = Set<AnyCancellable>()

    init() {
        timer
            .connect()
            .store(in: &cancellable)
    }

    deinit {
        cancellable.forEach { $0.cancel() }
    }
}
