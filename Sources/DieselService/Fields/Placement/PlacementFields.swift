// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Placement
import protocol Catena.Fields

protocol PlacementFields: Fields where Model == Placement.Identified {}
