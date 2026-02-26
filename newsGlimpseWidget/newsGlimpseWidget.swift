//
//  newsGlimpseWidget.swift
//  newsGlimpseWidget
//
//  Created by Ayush Bhople on 25/02/26.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    
    private func fetchImage(from urlString: String?) async -> UIImage? {
        guard let s = urlString, let url = URL(string: s) else { return nil }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let http = response as? HTTPURLResponse, (200..<300).contains(http.statusCode) else { return nil }
            return UIImage(data: data)
        } catch {
            return nil
        }
    }
    
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(
            date: Date(),
            newsCurrent: MainNews.placeholderForWidget,
            backgroundImage: UIImage(named: "testImage")
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        Task {
            do {
                let articles = try await NewsServiceWidget.shared.fetchTopHeadForWidget()
                let first = articles.first
                let image = await fetchImage(from: first?.urlToImage)
                completion(SimpleEntry(date: Date(), newsCurrent: first ?? MainNews.placeholderForWidget, backgroundImage: image))
            } catch {
                completion(SimpleEntry(date: Date(), newsCurrent: MainNews.placeholderForWidget, backgroundImage: UIImage(named: "testImage")))
            }
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task {
            let now = Date()
            let refresh = now.addingTimeInterval(35 * 60)
            do {
                let articles = try await NewsServiceWidget.shared.fetchTopHeadForWidget()
                let first = articles.first
                let image = await fetchImage(from: first?.urlToImage)
                let entry = SimpleEntry(date: now, newsCurrent: first ?? MainNews.placeholderForWidget, backgroundImage: image)
                let timeline = Timeline(entries: [entry], policy: .after(refresh))
                completion(timeline)
            } catch {
                let entry = SimpleEntry(date: now, newsCurrent: MainNews.placeholderForWidget, backgroundImage: UIImage(named: "testImage"))
                let timeline = Timeline(entries: [entry], policy: .after(refresh))
                completion(timeline)
            }
        }
    }

//    func relevances() async -> WidgetRelevances<Void> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let newsCurrent: MainNews?
    let backgroundImage: UIImage?
}

struct newsGlimpseWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family

    var body: some View {
        switch family {
        case .systemMedium:
            var backImg = entry.backgroundImage ?? UIImage(named: "testImage")
            ZStack {
                Group {
                    ContainerRelativeShape()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(
                                    colors: [
                                        Color.black.opacity(0.1), Color.black.opacity(0.8)
                                    ]
                                ),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                    
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text(entry.newsCurrent?.title ?? "Top sports headlines")
                            .font(.subheadline)
                            .fontWeight(.heavy)
                            .lineLimit(5)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                    .padding([.bottom], 12)
                    .padding([.horizontal], 8)
                }
            }
//            .containerBackground(
//                ImagePaint(image: Image(uiImage: backImg!), scale: 1), for: .widget
//            )
            .containerBackground(for: .widget) {
                Image(uiImage: backImg!)
                    .resizable()
                    .scaledToFill()
            }
            .clipped()
            // Deep link into your app if you have a route for article URLs
    //        .widgetURL(URL(string: entry.article?.url ?? ""))
            
        @unknown default:
            EmptyView()
        }
        
    }

    private func shortDateString(from iso: String) -> String {
        guard iso.count >= 10 else { return "" }
        let end = iso.index(iso.startIndex, offsetBy: 9)
        return String(iso[...end])
    }
}

struct newsGlimpseWidget: Widget {
    let kind: String = "newsGlimpseWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            newsGlimpseWidgetEntryView(entry: entry)
        }
        .contentMarginsDisabled()
        .containerBackgroundRemovable(false)
        .configurationDisplayName("Top news glimpse")
        .description("Get the glimpse of the recent news in sports")
        .supportedFamilies([.systemMedium])
    }
}

//#Preview(as: .systemSmall) {
//    newsGlimpseWidget()
//} timeline: {
//    SimpleEntry(date: .now, newsCurrent: MainNews.placeholderForWidget)
//    SimpleEntry(date: .now.addingTimeInterval(3600), newsCurrent: MainNews.placeholderForWidget)
//}


struct TestWidgetEntryView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            newsGlimpseWidgetEntryView(entry: SimpleEntry(date: .now, newsCurrent: MainNews.placeholderForWidget, backgroundImage: UIImage(named: "testImage")))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}

