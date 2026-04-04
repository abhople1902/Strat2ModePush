//
//  TestNewsView.swift
//  Downforce
//
//  Created by Ayush Bhople on 31/03/26.
//

import SwiftUI

struct TestNewsView: View {
    var body: some View {
        VStack {
            Text("Label")
        }
    }
}

#Preview {
    TestNewsView()
}


/*
 Wireframe based on your description (horizontal scroll, vertical rectangle cells, two visible per screen width):

 ⸻

 Main Screen Layout (News Feed)

 --------------------------------------------------
 |                                                |
 |              Top Header / Title                |
 |        (UILabel / Navigation Bar)              |
 |                                                |
 --------------------------------------------------

 --------------------------------------------------
 | Section Title (e.g., "Top Stories")            |
 | (UILabel)                                      |
 --------------------------------------------------

 |<---------------------------------------------->|
 |  HORIZONTAL SCROLL AREA                        |
 |                                                |
 |  [ Cell 1 ]   [ Cell 2 ]   [ Cell 3 ] ...      |
 |  (Tall Rect) (Tall Rect) (Tall Rect)           |
 |                                                |
 |  Each cell ≈ 50% width of screen               |
 |  Height > width (portrait rectangle)           |
 |                                                |
 |  Scroll Direction →                            |
 |<---------------------------------------------->|

 --------------------------------------------------
 | Section Title (e.g., "Latest News")            |
 --------------------------------------------------

 |  Vertical List (optional below)                |
 |  [ Standard News Cell ]                        |
 |  [ Standard News Cell ]                        |
 --------------------------------------------------


 ⸻

 Horizontal Cell (News Card) Layout

  -------------------------
 |        Image            |   (UIImageView)
 |   (Top portion)         |
 |-------------------------|
 |  Category / Tag         |   (UILabel)
 |-------------------------|
 |  Headline (2–3 lines)   |   (UILabel)
 |-------------------------|
 |  Source • Time          |   (UILabel)
  -------------------------


 ⸻

 View Types Used

 Container Structure
     •    UIViewController
     •    UIScrollView (optional if entire page scrolls)
     •    UIStackView (optional for vertical sections)

 Horizontal Section
     •    UICollectionView
     •    scrollDirection = horizontal
     •    UICollectionViewFlowLayout

 Cell
     •    UICollectionViewCell
     •    UIImageView
     •    UILabel (multiple)

 Sizing Logic
     •    Cell width: ~50% of screen width (minus spacing)
     •    Cell height: larger than width (portrait card style)
     •    Minimum line spacing: small (8–12pt)
     •    Section inset: slight padding on left/right

 ⸻

 Behavior Summary
     •    Horizontal swipe reveals more news cards
     •    Two cards visible at a time
     •    Cards feel like “stories” or “featured news”
     •    Can snap-to-center (optional enhancement)

 ⸻

 If needed, next step can refine spacing, exact proportions, or compare UICollectionView vs UIScrollView + UIStackView.

 */
