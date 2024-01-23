// Copyright © Fleuronic LLC. All rights reserved.

import struct Foundation.UUID
import struct Identity.Identifier

extension Identifier where Value.RawIdentifier == UUID {
	static var random: Self { .init(rawValue: .init()) }
}
