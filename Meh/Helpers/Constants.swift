//
//  Constants.swift
//  Meh
//
//  Created by Raj Raval on 28/01/24.
//

import Foundation

struct Constants {

    static var appGroup: String {
        #if BETA
            return "group.com.rajraval.Meh-Beta"
        #else
            return "group.com.rajraval.Meh"
        #endif
    }

}
