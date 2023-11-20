// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Slot
import struct Catena.IDFields
import protocol Catena.Fields
import protocol Schemata.ModelProjection

public protocol SlotFields: Fields where Model == Slot.Identified {}

// MARK: -
extension IDFields<Slot.Identified>: SlotFields {}
