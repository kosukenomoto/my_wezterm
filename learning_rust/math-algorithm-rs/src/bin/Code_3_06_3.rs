use math_algorithm_rs::Scanner;

// 再帰で階乗を計算（ベースケース: n==1）
// Rustポイント: 再帰関数は末尾最適化されないため、nが大きすぎると再帰深度に注意。
fn fac(n: i64) -> i64 { if n == 1 { 1 } else { fac(n - 1) * n } }

fn main() {
    let mut sc = Scanner::new();
    let n: i64 = sc.next();
    println!("{}", fac(n));
}
