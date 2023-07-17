// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Event

public protocol SlotSpec {
	associatedtype SlotListResult

	func listSlots(comprisingEventWith id: Event.ID) -> AsyncStream<SlotListResult>
}
