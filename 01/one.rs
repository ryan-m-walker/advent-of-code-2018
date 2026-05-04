use std::fs;

fn main() {
    let input = fs::read_to_string("input.txt").expect("Failed to read input.txt");
    let sum: i32 = input
        .lines()
        .filter(|line| !line.is_empty())
        .map(|line| line.parse::<i32>().expect("Failed to parse number"))
        .sum();
    println!("{}", sum);
}
