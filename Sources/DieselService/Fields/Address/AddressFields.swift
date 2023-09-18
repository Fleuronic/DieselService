// Copyright © Fleuronic LLC. All rights reserved.

import protocol Catena.Fields
import struct Diesel.Address
import protocol Schemata.ModelProjection

public protocol AddressFields: Fields where Model == Address.Identified {}

// MARK: -
public extension Address.Identified {
	enum CodingKeys: String, CodingKey {
		case id
		case streetAddress
		case zipCode
		case location
	}
}
