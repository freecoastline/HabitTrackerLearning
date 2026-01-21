package main

import "fmt"

func formatHabit(name string, days int) string {
	return name + ": " + fmt.Sprintf("%d days", days)
}

func main() {
	const maxHabits = 10
	habitName := "Exercise"
	var streak int = 5
	result := formatHabit(habitName, streak)
	fmt.Println(maxHabits)
	fmt.Println(habitName)
	fmt.Println(streak)
	fmt.Println(result)
}
