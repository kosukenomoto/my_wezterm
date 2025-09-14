use math_algorithm_rs::Scanner;

// N%4==0 なら後手必勝、それ以外は先手
fn main() {
    let mut sc = Scanner::new();
    let n: i64 = sc.next();
    if n % 4 == 0 { println!("Second"); } else { println!("First"); }
}
