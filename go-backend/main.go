package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"strings"

	_ "github.com/lib/pq"
)

type Habit struct {
	ID       string `json:"id"`
	Name     string `json:"name"`
	ColorHex string `json:"colorHex"`
	Streak   int    `json:"streak"`
}

var habits = []Habit{
	{ID: "1", Name: "Exercise", ColorHex: "#34C759", Streak: 5},
	{ID: "2", Name: "Reading", ColorHex: "#007AFF", Streak: 12},
}

func healthHandler(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(map[string]string{"status": "ok"})
}

func habitsHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method == http.MethodGet {
		w.Header().Set("Content-Type", "application/json")
		json.NewEncoder(w).Encode(habits)
	} else if r.Method == http.MethodPost {
		var habit Habit

		err := json.NewDecoder(r.Body).Decode(&habit)
		if err != nil {
			w.WriteHeader(http.StatusBadRequest)
			json.NewEncoder(w).Encode(map[string]string{"error": "Invalid JSON"})
			return
		}
		habit.ID = fmt.Sprintf("%d", len(habits)+1)
		habit.Streak = 0
		habits = append(habits, habit)
		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusCreated)
		json.NewEncoder(w).Encode(habit)
	} else {
		w.WriteHeader(http.StatusMethodNotAllowed)
	}
}

func habitByIDHandler(w http.ResponseWriter, r *http.Request) {
	id := strings.TrimPrefix(r.URL.Path, "/habits/")
	fmt.Printf("DEBUG: Exwtracted ID='%s' from path='%s'\n", id, r.URL.Path)
	if r.Method == http.MethodGet {
		for _, habit := range habits {
			if habit.ID == id {
				w.Header().Set("Content-Type", "application/json")
				json.NewEncoder(w).Encode(habit)
				return
			}
		}
		w.WriteHeader(http.StatusNotFound)
		json.NewEncoder(w).Encode(map[string]string{"error": "Hadit is not found"})
	} else if r.Method == http.MethodPut {
		var updatetedHabit Habit
		err := json.NewDecoder(r.Body).Decode(&updatetedHabit)
		if err != nil {
			w.WriteHeader(http.StatusBadRequest)
			json.NewEncoder(w).Encode(map[string]string{"error": "Invalid Request"})
		}

		for i, habit := range habits {
			if habit.ID == id {
				updatetedHabit.ID = id
				habits[i] = updatetedHabit
				w.Header().Set("Content-type", "application/json")
				json.NewEncoder(w).Encode(updatetedHabit)
				return
			}
		}
		w.WriteHeader(http.StatusNotFound)
		json.NewEncoder(w).Encode(map[string]string{"error": "Habit not found"})
	} else if r.Method == http.MethodDelete {
		for i, habit := range habits {
			if habit.ID == id {
				habits = append(habits[:i], habits[i+1:]...)
				w.WriteHeader(http.StatusNoContent)
				return
			}
		}

		w.WriteHeader(http.StatusNotFound)
		json.NewEncoder(w).Encode(map[string]string{"error": "Habit not found"})
	} else {
		w.WriteHeader(http.StatusMethodNotAllowed)
	}
}

func formatHabit(name string, days int) string {
	return name + ": " + fmt.Sprintf("%d days", days)
}

func getLevel(streak int) string {
	if streak < 7 {
		return "Beginner"
	} else if streak < 30 {
		return "Intermediate"
	} else {
		return "Expert"
	}
}

func (h Habit) Display() string {
	return fmt.Sprintf("%s (%s) - streak %d days", h.Name, h.ColorHex, h.Streak)
}

func (h *Habit) IncrementStreak() {
	h.Streak = h.Streak + 1
}

func main() {
	connStr := "user=ken dbname=habittracker sslmode=disable"
	db, err := sql.Open("postgres", connStr)
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()
	err = db.Ping()
	if err != nil {
		log.Fatal(err)
	}
	fmt.Println("Successfully connected to database!")
}
