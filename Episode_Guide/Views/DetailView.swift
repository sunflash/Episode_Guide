//
//  DetailView.swift
//  Episode_Guide
//
//  Created by Min Wu on 22/03/2020.
//  Copyright © 2020 sunflash. All rights reserved.
//

import Foundation
import SwiftUI

struct DetailView: View {

    @EnvironmentObject var series: Series

    var selectedEpisode: TVEpisode

    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading){
                seriesTitleView
                episodeView
                RemoteImage(url: selectedEpisode.poster)
                episodeInfoView
                episodeMetaDataView
                episodeCastView
            }
        }
        .navigationBarTitle(Text(selectedEpisode.title.value()))
    }

    var seriesTitleView: some View {
        HStack (alignment: .top){
            Text(series.title)
                .padding().font(.headline).foregroundColor(Color(.label))
            Spacer()
        }
    }

    var episodeView: some View {
        HStack(alignment: .top, spacing: 10){
            VStack(spacing: 5) {
                Text("Season").font(.footnote).foregroundColor(Color(.label))
                Text(selectedEpisode.season.value()).font(.body).foregroundColor(Color(.label))
            }
            VStack(spacing: 5) {
                 Text("Episode").font(.footnote).foregroundColor(Color(.label))
                 Text(selectedEpisode.episode.value()).font(.body).foregroundColor(Color(.label))
            }
            Spacer()
        }.padding(.leading)
    }

    var episodeInfoView: some View {
        VStack(alignment: .leading, spacing: 6) {
            episodeTitle
            episodeGeneral
            HStack(alignment: .center, spacing: 8) {
                episodeGenre
                episodeRating
            }
            episodePlot
        }.padding()
    }

    var episodeTitle: some View {
        Text(selectedEpisode.title.value())
             .font(.system(size: 22)).foregroundColor(Color(.label))
    }

    var episodeGeneral: some View {
        let items = [selectedEpisode.released,
                     selectedEpisode.rated,
                     selectedEpisode.runtime].compactMap {$0.value()}.filter {!$0.isEmpty}
        return Group {
            HStack(spacing: 5) {
                ForEach(items, id: \.self) { item in
                    Text(item).font(.subheadline).foregroundColor(Color(.secondaryLabel))
                }
                Spacer()
          }
        }
    }

    var episodeGenre: some View {
        Group {
            if !selectedEpisode.genre.value().isEmpty {
                Text(selectedEpisode.genre.value())
                    .padding(3)
                    .overlay(
                        RoundedRectangle(cornerRadius: 3)
                            .stroke(Color(.systemGray), lineWidth: 1)
                    )
                    .font(.subheadline)
                    .foregroundColor(Color(.systemGray))
            }
        }
    }

    // SwiftUI Text have issue with rendering long text,
    // it will get compress and truncate at some length.
    // .fixedSize(horizontal: false, vertical: true) workaroud can alleviate the issue,
    var episodePlot: some View {
        Text(selectedEpisode.plot.value())
            .padding(.top, 5)
            .font(.body)
            .foregroundColor(Color(.label))
            .fixedSize(horizontal: false, vertical: true)
    }

    var episodeRating: some View {
        HStack(spacing: 3) {
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: 15, height: 15)
                .foregroundColor(Color(.systemYellow))
            Text(selectedEpisode.imdbRating.value())
                .font(.subheadline)
                .foregroundColor(Color(.secondaryLabel))
        }
    }

    var episodeMetaDataView: some View {
        Group {
            Text("Released").padding(.leading).padding(.top, 20).font(.headline).foregroundColor(Color(.label))
            Divider()
            VStack(alignment: .leading, spacing: 5) {
                infoRow(name: "Language", value: selectedEpisode.language.value())
                infoRow(name: "Coutry", value: selectedEpisode.country.value())
                infoRow(name: "Year", value: selectedEpisode.year.value())
            }.padding(.leading)
            Divider()
        }
    }

    var episodeCastView: some View {
        Group {
            Text("Cast").padding(.leading).padding(.top, 20).font(.headline).foregroundColor(Color(.label))
            Divider()
            VStack(alignment: .leading, spacing: 5) {
                infoRow(name: "Director", value: selectedEpisode.director.value())
                infoRow(name: "Actors", value: selectedEpisode.actors.value())
                infoRow(name: "Writer", value: selectedEpisode.writer.value())
            }.padding(.leading)
            Divider()
        }
    }

    func infoRow(name: String, value: String) -> some View {
        return Group {
            if !name.isEmpty && !value.isEmpty {
                Text("\(name): ").font(.body).foregroundColor(Color(.label))
                    + Text(value).font(.body).foregroundColor(Color(.secondaryLabel))
            }
        }
    }

}

#if DEBUG
struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            exampleDetailView(season: "1", episode: "3")
                .environmentObject(Series(fileName: Config.dataFileName))
                .environment(\.colorScheme, .light)
        }
    }

    static func exampleDetailView(season: String, episode: String) -> some View {
        let series = DataSource.shared.getTVSeriesData(Config.dataFileName)
        let s = (series?.seasons?.first {$0.seasonNumber == season})
        let e = (s?.episodes?.first {$0.episode.value() == episode})
        if let exampleEpisode = e {
            return AnyView(DetailView(selectedEpisode: exampleEpisode))
        }
        return AnyView(Text("No example episode for preview"))
    }
}
#endif
