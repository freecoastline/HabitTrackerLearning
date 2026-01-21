package main

import "fmt"

type Habit struct {
	Name     string
	ColorHex string
	Streak   int
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
	const maxHabits = 10
	habitName := "Exercise"
	var streak int = 25
	result := formatHabit(habitName, streak)
	level := getLevel(streak)
	fmt.Println(maxHabits)
	fmt.Println(habitName)
	fmt.Println(streak)
	fmt.Println(result)
	fmt.Println("Level:", level)
	fmt.Println(habit.Name)
	fmt.Println(habit.ColorHex)
	fmt.Println(habit.Streak)
	habit.IncrementStreak()
	fmt.Println(habit.Display())
}
