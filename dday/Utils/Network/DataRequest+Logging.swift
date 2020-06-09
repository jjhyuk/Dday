//
//  DataRequest+Logging.swift
//  dday
//
//  Created by jinhyuk on 2020/06/09.
//  Copyright © 2020 jinhyuk. All rights reserved.
//

import Foundation
import Alamofire

extension DataRequest {
    
    public func debugLog() -> DataRequest {
        
        //이쁘게 보이게 바꿔야됨
        JHLog(self.description)
        
        return self
    }
}
