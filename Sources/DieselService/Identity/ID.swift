// Copyright © Fleuronic LLC. All rights reserved.

import Identity

import struct Foundation.UUID

extension Identifier where Value.RawIdentifier == UUID {
	static var random: Self {
		.init(rawValue: .init())
	}
}
