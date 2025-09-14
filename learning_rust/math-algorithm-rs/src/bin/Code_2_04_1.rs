use math_algorithm_rs::Scanner;

// 入力: N / 出力: 2*N+3（四則演算の基本）
fn main() {
    let mut sc = Scanner::new();
    let n: i64 = sc.next();
    println!("{}", 2 * n + 3);
}
