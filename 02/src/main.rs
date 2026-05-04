use std::collections::HashMap;
use std::fs;

fn part_one(ids: &[&str]) -> usize {
    let mut twos = 0;
    let mut threes = 0;

    for id in ids {
        let mut freq: HashMap<char, usize> = HashMap::new();
        for ch in id.chars() {
            *freq.entry(ch).or_insert(0) += 1;
        }

        if freq.values().any(|&v| v == 2) {
            twos += 1;
        }
        if freq.values().any(|&v| v == 3) {
            threes += 1;
        }
    }

    twos * threes
}

fn part_two(ids: &[&str]) -> String {
    for (i, a) in ids.iter().enumerate() {
        for b in &ids[i + 1..] {
            let common: String = a
                .chars()
                .zip(b.chars())
                .filter(|(ca, cb)| ca == cb)
                .map(|(c, _)| c)
                .collect();

            if common.len() == a.len() - 1 {
                return common;
            }
        }
    }
    String::new()
}

fn main() {
    let input = fs::read_to_string("input.txt").expect("Failed to read input.txt");
    let ids: Vec<&str> = input.lines().collect();

    println!("Part 1: {}", part_one(&ids));
    println!("Part 2: {}", part_two(&ids));
}
