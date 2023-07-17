// Copyright © Fleuronic LLC. All rights reserved.

import Schemata

import struct Diesel.Corps
import struct Diesel.Location
import protocol Identity.Identifiable

public struct CorpsNameFields {
    public let id: Corps.ID
    public let name: String
}

// MARK: -
extension CorpsNameFields: CorpsFields {
    // MARK: ModelProjection
    public static let projection = Projection<Corps.Identified, Self>(
        Self.init,
        \.id,
        \.value.name
    )
}
