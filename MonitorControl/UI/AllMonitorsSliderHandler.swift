//
//  AllMonitorsSliderHandler.swift
//  MonitorControl
//
//  Created by Tobias Holtdirk on 26.09.20.
//  Copyright © 2020 Guillaume Broder. All rights reserved.
//

import Cocoa
import DDC

class AllMonitorsSliderHandler {
  var slider: NSSlider?
  var handlers: [SliderHandler]
  let cmd: DDC.Command

  public init(handlers: [SliderHandler], command: DDC.Command) {
    self.handlers = handlers
    self.cmd = command
  }
  
  @objc func valueChanged(slider: NSSlider) {
    let snapInterval = 25
    let snapThreshold = 3
    var value = slider.integerValue

    let closest = (value + snapInterval / 2) / snapInterval * snapInterval
    if abs(closest - value) <= snapThreshold {
      value = closest
      slider.integerValue = value
    }
    
    for handler in self.handlers {
      handler.slider!.integerValue = value
      handler.valueChanged(slider: handler.slider!)
    }
  }
}
