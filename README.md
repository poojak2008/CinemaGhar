# CinemaGhar 🎬

[![Platform](https://img.shields.io/badge/Platform-iOS%2017.0%2B-blue.svg?style=flat-square)](https://developer.apple.com/ios/)
[![Swift](https://img.shields.io/badge/Swift-5.0%2B-orange.svg?style=flat-square)](https://developer.apple.com/swift/)
[![Architecture](https://img.shields.io/badge/Architecture-MVC-green.svg?style=flat-square)](https://developer.apple.com/library/archive/documentation/General/Concepts/CocoaDesignPatterns/Articles/ModelViewController.html)

CinemaGhar is a feature-rich, modern entertainment discovery iOS application. Built completely programmatically utilizing standard Apple frameworks, it acts as a centralized media powerhouse. Users can seamlessly explore global trending movies/TV shows, perform instantaneous deep searches, stream trailer previews via real-time YouTube integration, and leverage robust local storage to track their all-time favorite titles offline.

---

## 📸 App Interface

| 📱 Splash Screen | 🏠 Home Dashboard | 🔍 Content Discovery |
| :---: | :---: | :---: |
| <img src="CinemaGhar/ScreenShots/Screenshot 2026-07-01 at 12.47.56 PM.png" width="220"/> | <img src="CinemaGhar/ScreenShots/Screenshot 2026-07-01 at 12.48.08 PM.png" width="220"/> | <img src="CinemaGhar/ScreenShots/Screenshot 2026-07-01 at 12.48.23 PM.png" width="220"/> |

| 📈 Trending Feed | 🎯 Deep Search Grid | 📺 Media Details |
| :---: | :---: | :---: |
| <img src="CinemaGhar/ScreenShots/Screenshot 2026-07-01 at 12.48.33 PM.png" width="220"/> | <img src="CinemaGhar/ScreenShots/Screenshot 2026-07-01 at 12.50.37 PM.png" width="220"/> | <img src="CinemaGhar/ScreenShots/Screenshot 2026-07-01 at 12.54.09 PM.png" width="220"/> |

| 💖 Curated Bookmarks |
| :---: |
| <img src="CinemaGhar/ScreenShots/Screenshot 2026-07-01 at 12.51.36 PM.png" width="220"/> |

---

## ✨ Core Features

* 🚀 **Dynamic Home Dashboard:** Spotlights an impactful, immersive hero banner containing primary cinematic titles alongside custom, horizontal scroll sections explicitly segmenting *Trending Movies*, *Trending TV*, *Popular selections*, and *Upcoming releases*.
* 🔍 **Smart Search Engine:** Instant, character-indexed grid layouts processing multi-node user queries cleanly on the fly.
* 📺 **YouTube Stream Integration:** In-app network engine mappings that fetch exact global titles and smoothly stream high-fidelity promotional trailers using optimized web canvas containers.
* 💾 **CoreData Local Persistence:** Highly structured internal cache databases managing instant additions, state lookups, and direct deletion parameters inside your personal "Favourites" portal.
* 🎨 **Bespoke UI Architecture:** A custom-engineered, glassmorphic floating navigation layout crafted programmatically with precision anchors and responsive touch mechanics.

---

## 🛠️ Architecture & Tech Stack

```text
 ┌─────────────────────────────────────────────────────────────┐
 │                         CinemaGhar                          │
 ├───────────────────┬─────────────────────┬───────────────────┤
 │    Frameworks     │     Persistence     │    Networking     │
 ├───────────────────┼─────────────────────┼───────────────────┤
 │ UIKit (100% Code) │ CoreData Persistence│ URLSession Engine │
 └───────────────────┴─────────────────────┴───────────────────┘

•	Language Platform: Swift 5+
•	Interface UI: Pure Programmatic UIKit Layouts (Zero Storyboards, Segues, or XIB files)
•	Architectural Blueprint: Strict MVC (Model-View-Controller) pattern guaranteeing cleanly decoupled internal data structures, performant view reusability, and rapid layout navigation rendering.
•	Persistent Cache: Native CoreData Engine (CinemaGharCoreData)
•	Asynchronous Networking: Safe concurrent API wrappers handling clean internal payload parsing.
📂 Project Directory Structure
CinemaGhar/
├── Application/        # Core lifecycle delegation (AppDelegate, SceneDelegate, Launch Configurations)
├── Managers/           # Global Infrastructure (APICaller Engine, CoreData State Persistence Controllers)
├── Models/             # Shared entities (Title Data Schemas, Web / YouTube Search Envelopes)
├── Resources/          # Asset catalogs, media color palettes, global custom Swift formatting extensions
└── Screens/            # Highly decoupled MVC module workspaces
    ├── Favourites/     # Local database view layers and user bookmark view controllers
    ├── Home/           # Dynamic home deck controllers and custom continuous layout systems
    ├── Search/         # Real-time keyword filter engines and matrix-grid result view components
    ├── TabBar/         # Dedicated floating navigation controller implementation 
    ├── Upcoming/       # Chronological data feeds processing future theater releases
    └── YoutubeView/    # Modular integrated video player canvas views


  
