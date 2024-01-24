// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Placement
import protocol Catena.Fields
import protocol Schemata.ModelProjection

public protocol PlacementFields: Fields where Model == Placement.Identified {}
