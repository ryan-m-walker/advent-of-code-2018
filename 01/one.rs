use std::fs;

fn calc(input: &str) -> i64 {
    input
        .lines()
        .filter(|line| !line.trim().is_empty())
        .map(|line| line.trim().parse::<i64>().unwrap())
        .sum()
}

fn main() {
    let input = fs::read_to_string("input.txt").expect("failed to read input.txt");
    println!("{}", calc(&input));
}
