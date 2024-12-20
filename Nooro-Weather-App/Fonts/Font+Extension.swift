//
//  Font+Extension.swift
//  Nooro-Weather-App
//
//  Created by Adolpho Francisco Zimmermann Piazza on 19/12/24.
//

import SwiftUI

extension Font {
    
    enum PoppinsWeight {
        case regular
        case medium
        case semiBold
    }
    
    static func poppins(weight: PoppinsWeight, size: CGFloat) -> Font {
        switch weight {
        case .regular:
            return .custom("Poppins-Regular", size: size)
        case .medium:
            return .custom("Poppins-Medium", size: size)
        case .semiBold:
            return .custom("Poppins-SemiBold", size: size)
        }
    }
    
}
