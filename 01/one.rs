use std::fs;

// Part 1: starting from a frequency of 0, apply every shift once and return
// the resulting frequency (i.e. the sum of all shifts).
fn calc(input: &str) -> i64 {
    input
        .lines()
        // Skip blank lines (e.g. a trailing newline at the end of the file).
        .filter(|line| !line.trim().is_empty())
        // Each line is a signed integer like "+3" or "-2"; parse it.
        .map(|line| line.trim().parse::<i64>().unwrap())
        .sum()
}

fn main() {
    let input = fs::read_to_string("input.txt").expect("failed to read input.txt");
    println!("{}", calc(&input));
}
