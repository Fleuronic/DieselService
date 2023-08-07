// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Slot
import protocol Catena.Fields
import protocol Schemata.ModelProjection

public protocol SlotFields: Fields where Model == Slot.Identified {}

// MARK: -
public extension Slot.Identified {
	enum CodingKeys: String, CodingKey {
		case id
		case time
		case feature
		case performance
	}
}
