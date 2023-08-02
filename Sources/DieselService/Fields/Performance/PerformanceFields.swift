// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Performance
import protocol Catena.Fields
import protocol Schemata.ModelProjection

public protocol PerformanceFields: Fields where Model == Performance.Identified {}
