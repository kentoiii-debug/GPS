//
//  Const.swift
//  tableview
//
//  Created by ssp on 2019/10/24.
//  Copyright © 2019 ssp. All rights reserved.
//

import Foundation

struct Const {

    struct Bluetooth {
        /// サービスのUUID
        struct Service {
            static let kUUID: String = "AEB7E500-F278-4627-9D79-BFC43EC4E089"
        }

        /// サービスのキャラクタリスティックのUUID
        struct Characteristic {
            static let kUUID01 = "AEB7E500-F278-4627-9D79-BFC43EC4E089"
            static let kUUID02 = "AEB7E500-F278-4627-9D79-BFC43EC4E089"
        }

        static let kPeripheralName = "Hoge Bluetooth"
    }

}


