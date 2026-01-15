# SwiftUI Learning Plan - HabitTracker Project

## Overview
A 12-week hands-on learning plan to master SwiftUI by building a complete HabitTracker app.

---

## Completed Weeks

### Week 1: SwiftUI Fundamentals
**Status:** Completed

**Topics Covered:**
- [x] SwiftUI project structure
- [x] Basic Views (Text, Image, Button)
- [x] View modifiers (.font, .foregroundColor, .padding)
- [x] Stacks (VStack, HStack, ZStack)
- [x] Preview system

**Project Milestone:** Basic app structure created

---

### Week 2: State Management Basics
**Status:** Completed

**Topics Covered:**
- [x] @State property wrapper
- [x] @Binding for child views
- [x] Two-way data binding
- [x] View updates and re-rendering
- [x] Value types vs Reference types

**Project Milestone:** Interactive habit checkbox working

---

### Week 3: Lists, Navigation & Forms
**Status:** Completed

**Topics Covered:**
- [x] List and ForEach
- [x] NavigationStack and NavigationLink
- [x] Form and form controls (TextField, Picker, Toggle)
- [x] Sheet presentation
- [x] Swipe actions
- [x] Toolbar and ToolbarItem

**Project Milestone:** Add/Edit habit forms working

---

### Week 4: Data Persistence with SwiftData
**Status:** Completed

**Topics Covered:**
- [x] @Model macro
- [x] ModelContainer configuration
- [x] @Query property wrapper
- [x] ModelContext (insert, delete, save)
- [x] @Attribute for unique constraints
- [x] Computed properties for non-supported types (Color → Hex)
- [x] Model relationships (@Relationship)
- [x] struct vs class (SwiftData requires classes)

**Project Milestone:** Habits persist across app launches, CheckIn history working

---

### Week 5: Architecture - MVVM Pattern
**Status:** Completed

**Topics Covered:**
- [x] ViewModel purpose and benefits
- [x] Separating business logic from Views
- [x] @Observable macro
- [x] Computed properties in SwiftUI Views
- [x] Why `lazy var` doesn't work in SwiftUI structs
- [x] Immutability of structs with `let`

**Project Milestone:** HabitListViewModel handling delete and seed operations

---

## Current Week

### Week 6: ViewModel Deep Dive & @StateObject
**Status:** In Progress

**Topics to Learn:**
- [ ] @StateObject vs @ObservedObject vs @State
- [ ] When to use each property wrapper
- [ ] ViewModel lifecycle management
- [ ] Single source of truth principle
- [ ] Dependency injection in SwiftUI

**Practice Tasks:**
1. Refactor ContentView to use @StateObject for ViewModel
2. Move AddHabitView logic to ViewModel
3. Create a shared ViewModel for related views

**Key Concepts:**
```swift
// @StateObject - Creates and OWNS the object (use in parent view)
@StateObject private var viewModel = HabitListViewModel()

// @ObservedObject - Receives object from parent (doesn't own it)
@ObservedObject var viewModel: HabitListViewModel

// @State - For simple value types owned by the view
@State private var isLoading = false
```

---

## Upcoming Weeks

### Week 7: Animations & Transitions
**Status:** Pending

**Topics to Learn:**
- [ ] Implicit animations (.animation modifier)
- [ ] Explicit animations (withAnimation)
- [ ] Transitions (.transition modifier)
- [ ] Custom animations (spring, easeInOut)
- [ ] Animating state changes
- [ ] matchedGeometryEffect

**Practice Tasks:**
1. Add animation when checking/unchecking habits
2. Animate habit row deletion
3. Add transition when presenting sheets
4. Create animated streak counter

---

### Week 8: Custom Components & ViewModifiers
**Status:** Pending

**Topics to Learn:**
- [ ] Creating reusable View components
- [ ] Custom ViewModifier
- [ ] View extensions for common styles
- [ ] @ViewBuilder for flexible content
- [ ] Generic Views
- [ ] Environment values

**Practice Tasks:**
1. Create custom HabitCardStyle modifier
2. Build reusable ColorPicker component
3. Create themed button styles
4. Extract common patterns into extensions

---

### Week 9: Advanced SwiftData
**Status:** Pending

**Topics to Learn:**
- [ ] SortDescriptor for sorting queries
- [ ] #Predicate for filtering
- [ ] FetchDescriptor options
- [ ] Batch operations
- [ ] Data migration strategies
- [ ] CloudKit sync basics

**Practice Tasks:**
1. Add sorting options (by name, date, color)
2. Implement habit search/filter
3. Add "completed today" filter
4. Create habit statistics queries

---

### Week 10: Networking & Async/Await
**Status:** Pending

**Topics to Learn:**
- [ ] async/await fundamentals
- [ ] URLSession for API calls
- [ ] Codable for JSON parsing
- [ ] Error handling with Result type
- [ ] Loading states and error UI
- [ ] Task cancellation

**Practice Tasks:**
1. Create mock API service
2. Add motivational quotes from API
3. Implement pull-to-refresh
4. Handle offline mode gracefully

---

### Week 11: Testing
**Status:** Pending

**Topics to Learn:**
- [ ] Unit testing ViewModels
- [ ] Testing SwiftData models
- [ ] XCTest basics
- [ ] Mock objects and dependency injection
- [ ] UI testing with XCUITest
- [ ] Test-driven development (TDD) intro

**Practice Tasks:**
1. Write tests for HabitListViewModel
2. Test streak calculation logic
3. Test habit CRUD operations
4. Create basic UI test for adding habit

---

### Week 12: Polish & App Store Prep
**Status:** Pending

**Topics to Learn:**
- [ ] Accessibility (VoiceOver, Dynamic Type)
- [ ] Localization basics
- [ ] App icons and launch screen
- [ ] Dark mode support
- [ ] Error handling and edge cases
- [ ] Performance optimization
- [ ] App Store submission process

**Practice Tasks:**
1. Add accessibility labels
2. Support Dynamic Type
3. Create app icon
4. Test on multiple device sizes
5. Add onboarding flow

---

## Bonus Topics (After Week 12)

### Advanced SwiftUI
- [ ] Custom layouts (Layout protocol)
- [ ] Canvas and drawing
- [ ] GeometryReader deep dive
- [ ] PreferenceKey for child-to-parent communication

### Beyond the Basics
- [ ] Widgets with WidgetKit
- [ ] Watch app companion
- [ ] Push notifications
- [ ] In-app purchases
- [ ] Core Data migration (if needed)

---

## Learning Resources

### Official Documentation
- [Apple SwiftUI Documentation](https://developer.apple.com/documentation/swiftui)
- [Apple SwiftData Documentation](https://developer.apple.com/documentation/swiftdata)
- [WWDC Videos](https://developer.apple.com/videos/)

### Recommended Courses
- Stanford CS193p (Free on YouTube)
- Hacking with Swift - 100 Days of SwiftUI
- Apple's SwiftUI Tutorials

### Practice Tips
1. **Build daily** - Even 30 minutes helps
2. **Break things** - Experiment and see what happens
3. **Read error messages** - They often tell you exactly what's wrong
4. **Use Previews** - Fast iteration without running simulator
5. **Ask "why"** - Understanding concepts > memorizing syntax

---

## Progress Tracker

| Week | Topic | Status |
|------|-------|--------|
| 1 | SwiftUI Fundamentals | Completed |
| 2 | State Management | Completed |
| 3 | Lists, Navigation, Forms | Completed |
| 4 | SwiftData Persistence | Completed |
| 5 | MVVM Architecture | Completed |
| 6 | ViewModel Deep Dive | **Current** |
| 7 | Animations | Pending |
| 8 | Custom Components | Pending |
| 9 | Advanced SwiftData | Pending |
| 10 | Networking | Pending |
| 11 | Testing | Pending |
| 12 | Polish & App Store | Pending |

---

## Notes

_Add your own notes, questions, and discoveries here as you learn!_

