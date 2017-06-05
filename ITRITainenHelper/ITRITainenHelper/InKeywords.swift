//
//  InKeywords.swift
//  ITRITainenHelper
//
//  Created by Oslo on 4/20/17.
//  Copyright © 2017 uscc. All rights reserved.
//

import Foundation


class InKeywords {
    var stringId: String!
    var keywordId: String!
    var lastUpdateTime: Int64!
    
    init() {
        
    }
    
    init(stringId: String, keywordId: String, lastUpdateTime: Int64) {
        self.stringId = stringId
        self.keywordId = keywordId
        self.lastUpdateTime = lastUpdateTime
    }
    
}
