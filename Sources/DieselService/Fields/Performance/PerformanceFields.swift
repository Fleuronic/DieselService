// Copyright © Fleuronic LLC. All rights reserved.

import protocol Catena.Fields
import struct Diesel.Performance
import protocol Schemata.ModelProjection

public protocol PerformanceFields: Fields where Model == Performance.Identified {}
