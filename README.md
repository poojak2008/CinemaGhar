# CinemaGhar 🎬

CinemaGhar is a feature-rich, modern iOS application built using UIKit and the classic MVC (Model-View-Controller) architectural pattern. It serves as a comprehensive media discovery platform, allowing users to explore trending movies/TV shows, search for titles, stream trailer previews via YouTube integration, and save favorites locally for offline access.

---

## 📸 App Screenshots

| Splash Screen | Home Screen | Content Discovery |
| --- | --- | --- |
| <img src="screenshots/Screenshot 2026-07-01 at 12.47.56 PM.png" width="230"> | <img src="screenshots/Screenshot 2026-07-01 at 12.48.08 PM.png" width="230"> | <img src="screenshots/Screenshot 2026-07-01 at 12.48.23 PM.png" width="230"> |

| Trending Feed | Deep Search | Detailed View & Trailer Previews |
| --- | --- | --- |
| <img src="screenshots/Screenshot 2026-07-01 at 12.48.33 PM.png" width="230"> | <img src="screenshots/Screenshot 2026-07-01 at 12.50.37 PM.png" width="230"> | <img src="screenshots/Screenshot 2026-07-01 at 12.54.09 PM.png" width="230"> |

*Check out your curated bookmarks directly inside the application via the dedicated tracking view:*
<img src="screenshots/Screenshot 2026-07-01 at 12.51.36 PM.png" width="240">

---

## ✨ Features

* **Dynamic Home Dashboard:** Features a prominent hero banner highlighting trending content alongside cleanly structured sections for Trending Movies, Trending TV, Popular, and Upcoming titles.
* **Smart Search Engine:** Instant, grid-based search functionality matching movie queries on the fly.
* **YouTube Video Integration:** Fetches and streams video content/trailers utilizing custom web preview views.
* **CoreData Persistence:** Fully functional local storage configuration enabling users to bookmark titles to their "Favourites" list securely.
* **Custom Navigation Layout:** Features a personalized, glassmorphic floating tab bar layout designed entirely programmatically.

---

## 🛠️ Architecture & Tech Stack

* **Language:** Swift
* **UI Framework:** UIKit (Fully Programmatic UI — Zero Storyboards/XIBs)
* **Design Pattern:** MVC (Model-View-Controller) separating data layouts, reusable UI components, and navigation flows.
* **Local Persistence:** CoreData (`CinemaGharCoreData`)
* **Networking:** URLSession asynchronously powering custom API managers

---

## 📂 Project Structure

The codebase is organized cleanly into modular groups:

```text
CinemaGhar/
├── Application/        # AppDelegate, SceneDelegate, and Launch Configurations
├── Managers/           # APICaller (Networking), DataPresistenceManager (CoreData handler)
├── Models/             # Data Models (Title, YoutubeSearchResponse) and ViewModels used for formatting cell data
├── Resources/          # Assets catalogs and custom Swift extensions
└── Screens/            # Feature-based MVC presentation modules
    ├── Favourites/     # Local database views & FavouritesViewController
    ├── Home/           # Home Controllers and custom layout structures
    ├── Search/         # Query controllers and grid results views
    ├── TabBar/         # Custom floating tab bar navigation container
    ├── Upcoming/       # Chronological release trackers
    └── YoutubeView/    # Tailored web/video player integration views
