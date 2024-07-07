//
//  CLLocationCoordinate2DExtension.swift
//  BookViewer
//
//  Created by junkai ji on 06/07/24.
//

import CoreLocation

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
