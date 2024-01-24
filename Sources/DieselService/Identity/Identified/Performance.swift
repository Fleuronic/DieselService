// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB
import Schemata

import struct Diesel.Corps
import struct Diesel.Event
import struct Diesel.Location
import struct Diesel.Performance
import struct Diesel.Placement
import struct Diesel.Venue
import struct Foundation.UUID
import protocol Catena.Model
import protocol Identity.Identifiable

public struct IdentifiedPerformance {
	public let id: Self.ID
	public let value: Performance
	public let corps: Corps.Identified
	public let placement: Placement.Identified!
}

// MARK: -
public extension Performance {
	typealias ID = Identified.ID
	typealias Identified = IdentifiedPerformance

	func identified(
		id: ID? = nil,
		corps: Corps.Identified,
		placement: Placement.Identified? = nil
	) -> Identified {
		.init(
			id: id ?? .random,
			value: self,
			corps: corps,
			placement: placement
		)
	}
}

// MARK: -
extension Performance.Identified: Identifiable {
	public typealias RawIdentifier = UUID
}

extension Performance.Identified: Catena.Model {
	// MARK: Model
	public static let schema = Schema(
		Self.init..."performances",
		\.id * "id",
		\.corps --> "corps",
		\.placement -->? "placement"
	)

	public var valueSet: ValueSet<Self> {
		[
			\.corps.id == corps.id,
			\.placement.id == placement?.id
		]
	}

	public static var relationships: Relationships {
		[
			\.corps.id: \.corps,
			\.placement.id: \.placement!
		]
	}
}

// MARK: -
private extension Performance.Identified {
	init(
		id: ID,
		corps: Corps.Identified,
		placement: Placement.Identified?
	) {
		self.id = id
		self.corps = corps
		self.placement = placement
		
		value = .init()
	}
}

// MARK: -
public extension [Performance.Identified] {
	var id: [Performance.ID] { map(\.id) }
	var corps: [Corps.Identified] { map(\.corps) }
	var placement: [Placement.Identified] { map(\.placement) }
}
