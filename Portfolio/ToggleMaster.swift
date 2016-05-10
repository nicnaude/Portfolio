//
//  ToggleMaster.swift
//  Portfolio
//
//  Created by Nicholas Naudé on 09/05/2016.
//  Copyright © 2016 Nicholas Naudé. All rights reserved.
//

import Foundation
import UIKit

extension UISplitViewController {
    func toggleMasterView() {
        let barButtonItem = self.displayModeButtonItem()
        UIApplication.sharedApplication().sendAction(barButtonItem.action, to: barButtonItem.target, from: nil, forEvent: nil)
    }
}