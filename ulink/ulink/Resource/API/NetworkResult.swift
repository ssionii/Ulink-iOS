//
//  NetworkResult.swift
//  ulink
//
//  Created by 송지훈 on 2020/07/01.
//  Copyright © 2020 송지훈. All rights reserved.
//

import Foundation


enum NetworkResult<T> {
    case success(T,T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}

enum CalendarNetworkResult<T> {
    case success(T)
    case requestErr
    case pathErr
    case serverErr
    case networkFail
}
