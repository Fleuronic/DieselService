// Copyright © Fleuronic LLC. All rights reserved.

import protocol Catena.Fields
import struct Diesel.Placement
import protocol Schemata.ModelProjection

public protocol PlacementFields: Fields where Model == Placement.Identified {}
