//
//  ContentView.swift
//  Episode_Guide
//
//  Created by MW on 22/03/2020.
//  Copyright © 2020 sunflash. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @EnvironmentObject var series: Series

    var body: some View {
        Group {
            if supportSplitView() {
                doubleColumnNavigationView
            } else {
                stackNavigationView
            }
        }
    }

    var doubleColumnNavigationView: some View {
        NavigationView {
            MasterView().navigationBarTitle("\(series.title)", displayMode: .inline)
            defaultDetailView
        }.navigationViewStyle(DoubleColumnNavigationViewStyle())
    }

    var stackNavigationView: some View {
        NavigationView {
            MasterView().navigationBarTitle("\(series.title)", displayMode: .inline)
        }.navigationViewStyle(StackNavigationViewStyle())
    }

    var defaultDetailView: some View {
        let defaultSeason = "1"
        let defaultEpisode = "1"
        let season = (series.seasons.first {$0.seasonNumber == defaultSeason })
        let episode = (season?.episodes?.first {$0.episode.value() == defaultEpisode})
        if let episode = episode {
            return AnyView(DetailView(selectedEpisode: episode))
        } else {
            return AnyView(Text(""))
        }
    }

    func supportSplitView() -> Bool {
        #if targetEnvironment(macCatalyst)
            return true
        #else
            // Note: SwiftUI split view on iPad requied Xcode 11.4 with iPadOS 13.4 framework onwards to work properly
            if #available(iOS 13.4, *) {
                return true
            } else {
                return false
            }
        #endif
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .environmentObject(Series(fileName: Config.dataFileName))
                .environment(\.colorScheme, .dark)
            ContentView()
                .environmentObject(Series(fileName: Config.dataFileName))
                .environment(\.colorScheme, .light)
        }
    }
}
#endif
