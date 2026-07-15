use std::collections::HashSet;
use std::fs;

// Part 2: repeatedly apply the shifts in order (looping back to the start as
// needed) and return the first frequency that is reached twice.
fn calc(input: &str) -> i64 {
    // Parse the shifts once up front so we can cycle over them cheaply.
    let shifts: Vec<i64> = input
        .lines()
        // Skip blank lines (e.g. a trailing newline at the end of the file).
        .filter(|line| !line.trim().is_empty())
        // Each line is a signed integer like "+3" or "-2"; parse it.
        .map(|line| line.trim().parse::<i64>().unwrap())
        .collect();

    // Track every frequency we've seen; the starting frequency of 0 counts.
    let mut seen = HashSet::new();
    let mut total = 0;
    seen.insert(total);

    // Cycle through the shifts until a frequency is reached twice.
    for shift in shifts.iter().cycle() {
        total += shift;
        // HashSet::insert returns false when the value was already present,
        // which means this is the first repeated frequency.
        if !seen.insert(total) {
            return total;
        }
    }

    // `cycle` only terminates early via the `return` above; an empty input
    // would loop forever, so reaching here means there was nothing to cycle.
    unreachable!("input list was empty")
}

fn main() {
    let input = fs::read_to_string("input.txt").expect("failed to read input.txt");
    println!("{}", calc(&input));
}
