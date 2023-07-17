// Copyright © Fleuronic LLC. All rights reserved.

import Schemata

import struct Diesel.Division
import protocol Identity.Identifiable

public struct DivisionAllFields {
	public let id: Division.ID
	public let name: String
}

// MARK: -
extension DivisionAllFields: DivisionFields {
	// MARK: ModelProjection
	public static let projection = Projection<Division.Identified, Self>(
		Self.init,
		\.id,
		\.value.name
	)
}
