use std::collections::HashSet;
use std::fs;

fn part_one(changes: &[i64]) -> i64 {
    changes.iter().sum()
}

fn part_two(changes: &[i64]) -> i64 {
    let mut seen = HashSet::new();
    let mut freq = 0;
    seen.insert(freq);

    loop {
        for &change in changes {
            freq += change;
            if !seen.insert(freq) {
                return freq;
            }
        }
    }
}

fn main() {
    let input = fs::read_to_string("input.txt").expect("Failed to read input.txt");
    let changes: Vec<i64> = input
        .lines()
        .filter(|line| !line.is_empty())
        .map(|line| line.parse().expect("Failed to parse number"))
        .collect();

    println!("Part 1: {}", part_one(&changes));
    println!("Part 2: {}", part_two(&changes));
}
