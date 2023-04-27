//
//  HW05_OTUS_NikitinALApp.swift
//  HW05-OTUS-NikitinAL
//
//  Created by Александр Никитин on 27.04.2023.
//

import SwiftUI

@main
struct HW05_OTUS_NikitinALApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(ViewModel())
        }
    }
}
