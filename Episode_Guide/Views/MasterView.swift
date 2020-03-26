//
//  MasterView.swift
//  Episode_Guide
//
//  Created by Min Wu on 22/03/2020.
//  Copyright © 2020 sunflash. All rights reserved.
//

import Foundation
import SwiftUI

struct MasterView: View {

    @EnvironmentObject var series: Series

    @State private var selectedSeason: String = "1"

    var body: some View {
        VStack {
            SeasonSelectionView(selectedSeason: $selectedSeason)
            Divider()
            EpisodeListView(selectedSeason: $selectedSeason)
        }
    }
}

struct SeasonSelectionView: View {

    @EnvironmentObject var series: Series

    @Binding var selectedSeason: String

    var body: some View {
        VStack(alignment: .leading) {
            Text("Season").font(.subheadline).foregroundColor(Color(.label))
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(series.seasons) { season in
                        Text(season.seasonNumber)
                            .font(.headline)
                            .padding(15)
                            .background(self.getBackgroundColor(season))
                            .clipShape(Circle())
                            .gesture(
                                TapGesture().onEnded { _ in
                                    self.selectedSeason = season.seasonNumber
                                }
                            )
                    }
                }
            }
        }.padding()
    }

    private func getBackgroundColor(_ season: TVSeason) -> Color {
        return self.selectedSeason == season.seasonNumber ? Color(.systemOrange) : Color.clear
    }
}

struct EpisodeItemView: View {

    var episode: TVEpisode

    var body: some View {
        HStack {
            RemoteImage(url: episode.poster, height: 70, width: 100)
            VStack(alignment: .leading) {
                Text("\(episode.episode.value()). \(episode.title.value())")
                    .foregroundColor(Color(.label))
                    .font(.body)
                    .lineLimit(1)
                Text("\(episode.released.value()) | \(episode.runtime.value())")
                    .foregroundColor(Color(.secondaryLabel))
                    .font(.subheadline)
                HStack {
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .padding(.top, -8)
                        .padding(.trailing, -5)
                        .foregroundColor(Color(.systemYellow))
                    Text(episode.imdbRating.value())
                        .font(.subheadline)
                        .padding(.top, -8)
                        .foregroundColor(Color(.secondaryLabel))
                }

            }
        }
    }
}

struct EpisodeListView: View {

    @EnvironmentObject var series: Series

    @Binding var selectedSeason: String

    var episodes: [TVEpisode] {
        let season = series.seasons.first {$0.seasonNumber == selectedSeason}
        let episodesSorted = season?.episodes?.sorted { $0.episode ?? "" < $1.episode ?? "" }
        return episodesSorted ?? []
    }

    // There seems to be a bug with the navigation link in Xcode version 11.3
    // Note: This problem only appears in simulator. It works fine on a real device.
    // The below code works as expect the first time you use the navigation link.
    // Unfortunately it becomes unresponsive the second time around.
    // Update: Seem to be fix in Xcode version 11.4
    var body: some View {
        List {
            ForEach(episodes) { episode in
                NavigationLink(
                    destination: DetailView(selectedEpisode: episode)
                ) {
                    EpisodeItemView(episode: episode)
                }
            }
        }
    }
}

#if DEBUG
struct EpisodeListView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            EpisodeListView(selectedSeason: .constant("1"))
                .environmentObject(Series(fileName: Config.dataFileName))
                .environment(\.colorScheme, .dark)
            EpisodeListView(selectedSeason: .constant("1"))
                .environmentObject(Series(fileName: Config.dataFileName))
                .environment(\.colorScheme, .light)
        }
    }
}
#endif
