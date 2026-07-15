use std::collections::HashSet;
use std::fs;

fn calc(input: &str) -> i64 {
    let shifts: Vec<i64> = input
        .lines()
        .filter(|line| !line.trim().is_empty())
        .map(|line| line.trim().parse::<i64>().unwrap())
        .collect();

    let mut seen = HashSet::new();
    let mut total = 0;
    seen.insert(total);

    // Cycle through the shifts until a frequency is reached twice.
    for shift in shifts.iter().cycle() {
        total += shift;
        if !seen.insert(total) {
            return total;
        }
    }

    unreachable!("input list was empty")
}

fn main() {
    let input = fs::read_to_string("input.txt").expect("failed to read input.txt");
    println!("{}", calc(&input));
}
