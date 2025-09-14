use math_algorithm_rs::Scanner;

// 入力: N / A1..AN を読み、合計を出力
// Rustポイント:
// - ループ for _ in 0..n は半開区間 [0, n)
fn main() {
    let mut sc = Scanner::new();
    let n: usize = sc.next();
    let mut ans: i64 = 0;
    for _ in 0..n { ans += sc.next::<i64>(); }
    println!("{}", ans);
}
