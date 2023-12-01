use std::error::Error;
use std::io::prelude::*;
use std::fs::File;
use std::io::BufReader;

use itertools::Itertools;

fn main() -> Result<(), Box<dyn Error>> {
    let f = File::open("../files/01.input")?;

    let lines: Vec<i32> = BufReader::new(f).
        lines().
        filter_map(|l| l.ok()).
        filter_map(|l| l.parse::<i32>().ok()).
        collect();

    let ans1 = lines.iter().combinations(2).
        find(|c| c[0] + c[1] == 2020).ok_or("404")?.
        iter().
        fold(1, |x, &y| x * y);

    println!("{}", "=".repeat(20));
    println!("{:?}", ans1);

    let ans2 = lines.iter().combinations(3).
        find(|c| c[0] + c[1] + c[2] == 2020).ok_or("404")?.
        iter().
        fold(1, |x, &y| x * y);

    println!("{}", "=".repeat(20));
    println!("{:?}", ans2);

    Ok(())
}
