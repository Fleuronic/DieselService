// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Event

extension Service: SlotSpec where API: SlotSpec, Database: SlotSpec {
	public func listSlots(comprisingEventWith id: Event.ID) -> AsyncStream<API.SlotListResult> {
		.init { continuation in
			Task {
				let slots = await api.listSlots(comprisingEventWith: id).value
				continuation.yield(slots)
				continuation.finish()
			}
		}
	}
}
