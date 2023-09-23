//
//  white_boardLiveActivity.swift
//  white_board
//
//  Created by tsaidarius on 2023/9/22.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct white_boardAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct white_boardLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: white_boardAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension white_boardAttributes {
    fileprivate static var preview: white_boardAttributes {
        white_boardAttributes(name: "World")
    }
}

extension white_boardAttributes.ContentState {
    fileprivate static var smiley: white_boardAttributes.ContentState {
        white_boardAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: white_boardAttributes.ContentState {
         white_boardAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: white_boardAttributes.preview) {
   white_boardLiveActivity()
} contentStates: {
    white_boardAttributes.ContentState.smiley
    white_boardAttributes.ContentState.starEyes
}
