// Copyright © Fleuronic LLC. All rights reserved.

import protocol Catena.Fields
import struct Diesel.Feature
import protocol Schemata.ModelProjection

public protocol FeatureFields: Fields where Model == Feature.Identified {}
