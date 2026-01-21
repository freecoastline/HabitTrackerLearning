package main

import (
	"encoding/json"
	"fmt"
)

type Habit struct {
	Name     string `json:"name"`
	ColorHex string `json:"colorHex"`
	Streak   int    `json:"streak"`
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
	habit := Habit{
		Name:     "Exercise",
		ColorHex: "#34C759",
		Streak:   5,
	}
	jsonData, _ := json.Marshal(habit)
	fmt.Println(string(jsonData))
}
