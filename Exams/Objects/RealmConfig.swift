//
//  RealmConfig.swift
//  Exams
//
//  Created by Aivars Meijers on 23.08.16.
//  Copyright © 2016. g. Realm Inc. All rights reserved.
//

import Foundation
import RealmSwift

private var configToken: dispatch_once_t = 0

enum RealmConfig {
    
    private static let mainConfig = Realm.Configuration(
        fileURL: NSURL.inDocumentsFolder("main.realm"),
        schemaVersion: 1
    )
    
    case Main
    
    var configuration: Realm.Configuration {
        switch self {
        case .Main:
            dispatch_once(&configToken) {
                
                Exams.copyInitialData(
                    NSBundle.mainBundle().URLForResource("default_v1.0", withExtension: "realm")!,
                    to: RealmConfig.mainConfig.fileURL!)
                
            }
            return RealmConfig.mainConfig
        }
    }
    
}