use std::collections::HashSet;
use std::fs;

fn main() {
    let input = fs::read_to_string("input.txt").expect("Failed to read input.txt");
    let changes: Vec<i32> = input
        .lines()
        .filter(|line| !line.is_empty())
        .map(|line| line.parse::<i32>().expect("Failed to parse number"))
        .collect();

    let mut seen = HashSet::new();
    let mut freq = 0;
    seen.insert(freq);

    loop {
        for &change in &changes {
            freq += change;
            if !seen.insert(freq) {
                println!("{}", freq);
                return;
            }
        }
    }
}
