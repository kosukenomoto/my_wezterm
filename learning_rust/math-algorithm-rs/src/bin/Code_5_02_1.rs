use math_algorithm_rs::Scanner;

// 2^N の下一桁：N%4に応じて 6,2,4,8 が周期で現れる
// Rustポイント: rem_euclid は「常に非負」の剰余（負数でも安全）。
fn main() {
    let mut sc = Scanner::new();
    let n: i64 = sc.next();
    match n.rem_euclid(4) {
        1 => println!("2"),
        2 => println!("4"),
        3 => println!("8"),
        _ => println!("6"), // 0
    }
}
