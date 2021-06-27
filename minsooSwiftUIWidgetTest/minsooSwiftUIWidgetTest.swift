//
//  minsooSwiftUIWidgetTest.swift
//  minsooSwiftUIWidgetTest
//
//  Created by MINSOO JEON on 2021/06/27.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct minsooSwiftUIWidgetTestEntryView : View {
    @Environment(\.widgetFamily) var widgetType
    var entry: Provider.Entry

    var body: some View {
        ZStack(content: {
            switch widgetType{
            case .systemSmall:
                Color.red
                VStack{
                    Text(entry.date, style: .time).foregroundColor(.black)
                    Text("It's Small Widget").foregroundColor(.black)
                }
            case .systemMedium:
                Color.orange
                VStack{
                    Text(entry.date, style: .time).foregroundColor(.black)
                    Text("It's Medium Widget").foregroundColor(.black)
                }
            case .systemLarge:
                Color.pink
                VStack{
                    Text(entry.date, style: .time).foregroundColor(.black)
                    Text("It's Large Widget").foregroundColor(.black)
                }
            @unknown default:
                Color.white
            }
        })
    }
}

@main
struct minsooSwiftUIWidgetTest: Widget {
    let kind: String = "minsooSwiftUIWidgetTest"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            minsooSwiftUIWidgetTestEntryView(entry: entry)
        }
        .configurationDisplayName("MinsooSwiftUIWidget")
        .description("위젯 테스트 입니다.")
    }
}

struct minsooSwiftUIWidgetTest_Previews: PreviewProvider {
    static var previews: some View {
        minsooSwiftUIWidgetTestEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
