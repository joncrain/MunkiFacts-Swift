import Foundation
import IOKit.ps
import FactPlugin

let factPlugin = FactPlugin()

let isPluggedIn: Bool = IOPSCopyExternalPowerAdapterDetails()?.takeRetainedValue() != nil
factPlugin.addFact(key: "ac_power", value: isPluggedIn)

factPlugin.write()