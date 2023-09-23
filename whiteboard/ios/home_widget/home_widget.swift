// //
// //  home_widget.swift
// //  home_widget
// //
// //  Created by tsaidarius on 2023/9/22.
// //

// import WidgetKit
// import SwiftUI


// struct Provider: AppIntentTimelineProvider {
//     func placeholder(in context: Context) -> SimpleEntry {
//         SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
//     }

//     func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
//         SimpleEntry(date: Date(), configuration: configuration)
//     }
    
//     func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
//         var entries: [SimpleEntry] = []

//         // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//         let currentDate = Date()
//         for hourOffset in 0 ..< 5 {
//             let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//             let entry = SimpleEntry(date: entryDate, configuration: configuration)
//             entries.append(entry)
//         }

//         return Timeline(entries: entries, policy: .atEnd)
//     }
// }

// struct SimpleEntry: TimelineEntry {
//     let date: Date
//     let configuration: ConfigurationAppIntent
// }

// struct home_widgetEntryView : View {
//     var entry: Provider.Entry

//     var body: some View {
//         VStack {
//             Text("Time:")
//             Text(entry.date, style: .time)

//             Text("Favorite Emoji:")
//             Text(entry.configuration.favoriteEmoji)
//         }
//     }
// }

// struct home_widget: Widget {
//     let kind: String = "home_widget"

//     var body: some WidgetConfiguration {
//         AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
//             home_widgetEntryView(entry: entry)
//                 .containerBackground(.fill.tertiary, for: .widget)
//         }
//     }
// }

// extension ConfigurationAppIntent {
//     fileprivate static var smiley: ConfigurationAppIntent {
//         let intent = ConfigurationAppIntent()
//         intent.favoriteEmoji = "😀"
//         return intent
//     }
    
//     fileprivate static var starEyes: ConfigurationAppIntent {
//         let intent = ConfigurationAppIntent()
//         intent.favoriteEmoji = "🤩"
//         return intent
//     }
// }

// #Preview(as: .systemSmall) {
//     home_widget()
// } timeline: {
//     SimpleEntry(date: .now, configuration: .smiley)
//     SimpleEntry(date: .now, configuration: .starEyes)
// }
import WidgetKit
import SwiftUI
import Intents

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), filename: "No screenshot available", displaySize: context.displaySize)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let userDefaults = UserDefaults(suiteName: "group.home_widget_group")
        let filename = userDefaults?.string(forKey: "filename") ?? "No screenshot available"
        let entry = SimpleEntry(date: Date(), filename: filename, displaySize: context.displaySize)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
          getSnapshot(in: context) { (entry) in
            let timeline = Timeline(entries: [entry], policy: .atEnd)
                      completion(timeline)
                  }
        }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let filename: String
    let displaySize: CGSize
}

struct home_widgetEntryView : View {
    var entry: Provider.Entry
    var CustomImage: some View {
            if let uiImage = UIImage(contentsOfFile: entry.filename) {
                let image = Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                return AnyView(image)
            }
            print("The image file could not be loaded")
            return AnyView(EmptyView())
        }
    var body: some View {
        VStack {
            CustomImage
            .scaledToFill()
            .padding(0)
        }   
        .widgetBackground(Color.clear)
    }
}
extension View {
    func widgetBackground(_ backgroundView: some View) -> some View {
        if #available(iOSApplicationExtension 17.0, *) {
            return containerBackground(for: .widget) {
                backgroundView
            }
        } else {
            return background(backgroundView)
        }
    }
}

struct home_widget: Widget {
    let kind: String = "home_widget"
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            home_widgetEntryView(entry: entry)
        }
        .configurationDisplayName("Home Widget")
        .description("This is my home widget.")
        .supportedFamilies([.systemSmall])
        .contentMarginsDisabled()

    }
}

//struct home_widget_demo_Previews: PreviewProvider {
//    static var previews: some View {
//        home_widget_demoEntryView(entry: SimpleEntry(date: Date(), filename: "filename", displaySize: context.displaySize))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}