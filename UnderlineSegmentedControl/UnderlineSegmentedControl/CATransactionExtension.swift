//
//  CATransactionExtension.swift
//  HandySwift
//
//  Created by Lusine Magauzyan on 30.10.22.
//

import QuartzCore

extension CATransaction {
    ///Disables system animations that are enabled on layers by default
    static func disableAnimations(_ completion: () -> Void) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        completion()
        CATransaction.commit()
    }
}
