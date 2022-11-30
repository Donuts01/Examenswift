//
//  ExamenJTApp.swift
//  ExamenJT
//
//  Created by CCDM18 on 17/11/22.
//

import SwiftUI

@main
struct ExamenJTApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(coreDM: CoreDataManager())
        }
    }
}
