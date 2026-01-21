# HabitTracker Backend - 8-Week Go Learning Plan

## Current iOS App State

**Models:**
- `Habit`: id (UUID), name, habitDescription, colorHex, createdAt, checkIns (relationship)
- `CheckIn`: id (UUID), date, habit (relationship)

**Operations:**
- CRUD for habits
- Check-in toggle (create/delete by date)
- Streak calculation (consecutive check-ins)
- Sorting, searching, filtering

**Tech Stack:**
- SwiftData (local persistence)
- SwiftUI (UI)
- MVVM architecture

---

## Week 1: Go Fundamentals

### Goals
- Install Go
- Learn syntax basics
- Write first HTTP server
- Understand Go's approach vs Swift

### Topics

#### Day 1-2: Setup & Basics
**Install & Configure:**
```bash
# Install Go
brew install go

# Verify installation
go version  # Should show 1.21+

# Setup workspace
mkdir ~/go-backend
cd ~/go-backend
go mod init habittracker-api
```

**Learn:**
- Variables, types, constants
- Functions and parameters
- Control flow (if, for, switch)
- Packages and imports

**Compare to Swift:**
| Swift | Go |
|-------|-----|
| `let x = 5` | `x := 5` |
| `var x: Int = 5` | `var x int = 5` |
| `func add(_ a: Int, _ b: Int) -> Int` | `func add(a int, b int) int` |

#### Day 3-4: Structs & Methods
**Learn:**
- Structs (like Swift structs)
- Methods on structs
- Pointers (new concept!)
- Interfaces (like Swift protocols)

**Example - Habit struct:**
```go
type Habit struct {
    ID          string    `json:"id"`
    Name        string    `json:"name"`
    Description string    `json:"description,omitempty"`
    ColorHex    string    `json:"colorHex"`
    CreatedAt   time.Time `json:"createdAt"`
}
```

#### Day 5-7: First HTTP Server
**Learn:**
- `net/http` package
- Handlers and routing
- JSON encoding/decoding
- Error handling

**Build:**
```go
package main

import (
    "encoding/json"
    "net/http"
)

func main() {
    http.HandleFunc("/health", healthHandler)
    http.ListenAndServe(":8080", nil)
}

func healthHandler(w http.ResponseWriter, r *http.Request) {
    json.NewEncoder(w).Encode(map[string]string{"status": "ok"})
}
```

**Test:** `curl http://localhost:8080/health`

---

## Week 2: REST API Fundamentals

### Goals
- Build CRUD endpoints for Habits
- Learn Go project structure
- Understand HTTP methods and status codes
- Practice with your coworker

### Project Structure
```
habittracker-api/
├── main.go                 # Entry point
├── models/
│   └── habit.go           # Habit struct
├── handlers/
│   └── habit_handler.go   # HTTP handlers
└── go.mod                 # Dependencies
```

### Endpoints to Build

**1. GET /habits** - List all habits
```go
// Response: [{"id": "...", "name": "Exercise", ...}]
```

**2. POST /habits** - Create new habit
```go
// Request: {"name": "Exercise", "colorHex": "#34C759"}
// Response: {"id": "...", "name": "Exercise", ...}
```

**3. GET /habits/:id** - Get single habit
**4. PUT /habits/:id** - Update habit
**5. DELETE /habits/:id** - Delete habit

### Key Concepts
- HTTP status codes (200, 201, 400, 404, 500)
- Request parsing and validation
- Response formatting
- Error handling patterns

---

## Week 3: Database Integration (PostgreSQL)

### Goals
- Install PostgreSQL locally
- Learn SQL basics
- Connect Go to database
- Implement proper CRUD with persistence

### Database Setup
```bash
# Install PostgreSQL
brew install postgresql

# Start server
brew services start postgresql

# Create database
createdb habittracker
```

### Schema Design
```sql
CREATE TABLE habits (
    id UUID PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    color_hex VARCHAR(7) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE checkins (
    id UUID PRIMARY KEY,
    habit_id UUID NOT NULL REFERENCES habits(id) ON DELETE CASCADE,
    date DATE NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    UNIQUE(habit_id, date)
);

CREATE INDEX idx_checkins_habit_date ON checkins(habit_id, date DESC);
```

### Go Database Libraries
Choose one:
1. **`database/sql`** + **`lib/pq`** - Standard library (recommended for learning)
2. **GORM** - ORM like SwiftData (easier but hides SQL)

**Example with database/sql:**
```go
import (
    "database/sql"
    _ "github.com/lib/pq"
)

func createHabit(db *sql.DB, habit *Habit) error {
    query := `INSERT INTO habits (id, name, description, color_hex, created_at)
              VALUES ($1, $2, $3, $4, $5)`
    _, err := db.Exec(query, habit.ID, habit.Name, habit.Description,
                      habit.ColorHex, habit.CreatedAt)
    return err
}
```

---

## Week 4: CheckIns & Business Logic

### Goals
- Add CheckIn endpoints
- Implement streak calculation
- Handle date/time properly
- Add validation

### CheckIn Endpoints

**1. POST /habits/:id/checkins** - Toggle check-in
```go
// Request: {"date": "2026-01-20"}
// Response: {"id": "...", "habitId": "...", "date": "2026-01-20"}
```

**2. GET /habits/:id/checkins** - List check-ins
```go
// Query params: ?from=2026-01-01&to=2026-01-31
// Response: [{"id": "...", "date": "2026-01-15"}, ...]
```

**3. DELETE /checkins/:id** - Delete check-in

### Streak Calculation
```go
func calculateStreak(db *sql.DB, habitID string) (int, error) {
    query := `
        SELECT date FROM checkins
        WHERE habit_id = $1
        ORDER BY date DESC
    `
    // Logic: count consecutive days from today backwards
}
```

### Date Handling
- Use `time.Time` in Go
- Store as `DATE` in PostgreSQL
- Handle timezone conversions for iOS

---

## Week 5: Authentication & User Management

### Goals
- Add user accounts
- Implement JWT authentication
- Secure endpoints
- Associate habits with users

### User Model
```sql
CREATE TABLE users (
    id UUID PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

ALTER TABLE habits ADD COLUMN user_id UUID REFERENCES users(id);
```

### Auth Endpoints
**1. POST /auth/register** - Create account
**2. POST /auth/login** - Get JWT token
**3. POST /auth/refresh** - Refresh token

### JWT Implementation
```go
import "github.com/golang-jwt/jwt/v5"

func generateToken(userID string) (string, error) {
    token := jwt.NewWithClaims(jwt.SigningMethodHS256, jwt.MapClaims{
        "user_id": userID,
        "exp":     time.Now().Add(time.Hour * 24).Unix(),
    })
    return token.SignedString([]byte("your-secret-key"))
}
```

### Middleware
```go
func authMiddleware(next http.HandlerFunc) http.HandlerFunc {
    return func(w http.ResponseWriter, r *http.Request) {
        // Verify JWT token from Authorization header
        // Add userID to request context
        next(w, r)
    }
}
```

---

## Week 6: iOS App Integration

### Goals
- Update iOS app to call backend API
- Handle authentication flow
- Implement sync strategy
- Test end-to-end

### iOS Changes Needed

**1. Create API Service**
```swift
// Services/HabitAPI.swift
enum HabitAPI {
    static let baseURL = "http://localhost:8080"

    static func fetchHabits(token: String) async throws -> [Habit] {
        let url = URL(string: "\(baseURL)/habits")!
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode([Habit].self, from: data)
    }

    static func createHabit(habit: Habit, token: String) async throws -> Habit {
        // POST /habits
    }

    // ... other methods
}
```

**2. Add Authentication State**
```swift
@Observable
class AuthViewModel {
    var token: String?
    var isAuthenticated: Bool { token != nil }

    func login(email: String, password: String) async throws {
        // POST /auth/login
        // Store token in Keychain
    }
}
```

**3. Sync Strategy**
- **Option A:** Replace SwiftData with API calls (simpler)
- **Option B:** Hybrid - SwiftData for offline, sync with API (better UX)

### Testing
1. Run Go server: `go run main.go`
2. Run iOS app in simulator
3. Test: Register → Login → Create habit → See in API

---

## Week 7: Deployment & Production

### Goals
- Deploy to cloud (Render/Railway/Fly.io)
- Setup environment variables
- Add logging and monitoring
- HTTPS and security

### Deployment Options

**Option 1: Render.com (Recommended - Free tier)**
```yaml
# render.yaml
services:
  - type: web
    name: habittracker-api
    env: go
    buildCommand: go build -o server
    startCommand: ./server
    envVars:
      - key: DATABASE_URL
        sync: false
      - key: JWT_SECRET
        generateValue: true
```

**Option 2: Railway.app**
- Connect GitHub repo
- Auto-deploy on push
- Managed PostgreSQL included

### Production Checklist
- [ ] Environment variables for secrets
- [ ] CORS configuration for iOS app
- [ ] Rate limiting
- [ ] Request logging
- [ ] Error monitoring (Sentry)
- [ ] Database migrations
- [ ] Health check endpoint
- [ ] README with setup instructions

---

## Week 8: Testing & Polish

### Goals
- Write unit tests
- Add integration tests
- Performance optimization
- Documentation

### Testing in Go
```go
// handlers/habit_handler_test.go
func TestCreateHabit(t *testing.T) {
    // Setup test database
    // Create test request
    // Assert response
}
```

### Performance
- Add database indexes
- Implement pagination
- Cache frequently accessed data
- Profile with `pprof`

### Documentation
```go
// Add comments for godoc
// CreateHabit creates a new habit for the authenticated user
// @Summary Create habit
// @Tags habits
// @Accept json
// @Produce json
// @Param habit body Habit true "Habit to create"
// @Success 201 {object} Habit
// @Router /habits [post]
func CreateHabit(w http.ResponseWriter, r *http.Request) {
    // ...
}
```

---

## Critical Files to Create

```
habittracker-api/
├── main.go                    # Server entry point
├── go.mod                     # Dependencies
├── models/
│   ├── habit.go              # Habit model
│   ├── checkin.go            # CheckIn model
│   └── user.go               # User model
├── handlers/
│   ├── habit_handler.go      # Habit CRUD
│   ├── checkin_handler.go    # CheckIn CRUD
│   └── auth_handler.go       # Auth endpoints
├── middleware/
│   ├── auth.go               # JWT verification
│   ├── cors.go               # CORS headers
│   └── logging.go            # Request logging
├── database/
│   ├── db.go                 # Connection setup
│   └── migrations/           # SQL migration files
├── utils/
│   ├── jwt.go                # JWT utilities
│   └── validation.go         # Input validation
└── tests/
    └── integration_test.go   # E2E tests
```

---

## iOS App Files to Modify/Create

```
HabitTrackerLearning/
├── Services/
│   ├── HabitAPI.swift        # API calls
│   └── AuthService.swift     # Authentication
├── ViewModels/
│   ├── HabitListViewModel.swift    # Update for API
│   └── AuthViewModel.swift         # New - auth state
└── Views/
    └── LoginView.swift       # New - login screen
```

---

## Go vs Swift Key Differences

| Concept | Swift | Go |
|---------|-------|-----|
| Nil safety | Optionals (`String?`) | Pointers can be nil |
| Error handling | `throws` / `try` / `catch` | Return `error` as value |
| Async | `async`/`await` | Goroutines + channels |
| Classes | `class` with inheritance | Structs + interfaces (composition) |
| Generics | Full support | Limited (improving) |
| Memory | ARC (automatic) | Garbage collection |

---

## Learning Resources

### Essential
1. **Go by Example** - https://gobyexample.com/
2. **Tour of Go** - https://go.dev/tour/
3. **Effective Go** - https://go.dev/doc/effective_go
4. **Your coworker!** - Pair program, code reviews

### REST API Specific
- "Let's Go" book by Alex Edwards
- "Build Web Applications with Golang"
- REST API tutorial: https://golang.org/doc/tutorial/web-service-gin

### Ask Your Coworker
- Code structure patterns they use
- Database library preference
- Deployment setup at work
- Code review your PRs

---

## Success Milestones

### Week 1
✅ "Hello World" HTTP server running
✅ Understand Go syntax basics
✅ Show coworker your first Go program

### Week 2
✅ Full CRUD API for Habits (in-memory)
✅ Test with `curl` or Postman
✅ Coworker reviews your code

### Week 4
✅ Database persistence working
✅ CheckIns and streaks functional
✅ API matches iOS app needs

### Week 6
✅ iOS app talking to Go backend
✅ Create habit on iPhone → See in database
✅ Demo to coworker

### Week 8
✅ Deployed to production URL
✅ Tests written and passing
✅ iOS app using production API
✅ Ready to add to resume!

---

## Daily Learning Routine

**30 minutes/day minimum:**
- Monday-Wednesday: Learn new concepts, write code
- Thursday: Review with coworker
- Friday: Build features
- Weekend: Catch up or explore advanced topics

**Use your coworker:**
- Daily: Quick questions via Slack
- Weekly: 30min pair programming session
- Biweekly: Code review

---

## Why This Plan Works

1. **Built-in Mentor** - Your coworker accelerates learning 10x
2. **Real Project** - HabitTracker backend is practical, not toy example
3. **Gradual** - Week 1 basics → Week 8 production
4. **Complete** - Backend + iOS integration
5. **Career Value** - Go + REST API skills are highly marketable

---

## Next Steps After Completion

- Add features: notifications, social, analytics
- Learn advanced Go: concurrency, profiling, optimization
- Explore: GraphQL, gRPC, microservices
- Consider: Contributing to open source Go projects
- Interview prep: Backend engineer roles

**You'll be a full-stack iOS + Backend developer!** 🚀
