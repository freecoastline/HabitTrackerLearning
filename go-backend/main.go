package main

import (
	"encoding/json"
	"fmt"
	"net/http"
)

type Habit struct {
	Name     string `json:"name"`
	ColorHex string `json:"colorHex"`
	Streak   int    `json:"streak"`
}

func healthHandler(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(map[string]string{"status": "ok"})
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
	http.HandleFunc("/health", healthHandler)
	fmt.Println("Server starting on: 8080")
	http.ListenAndServe(":8080", nil)
}
