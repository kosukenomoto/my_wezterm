use math_algorithm_rs::Scanner;

// 入力: N / (P,Q)×N / 出力: Σ(Q/P)
// Rustポイント: next::<i64>() as f64 で整数を浮動小数点へ変換。
fn main() {
    let mut sc = Scanner::new();
    let n: usize = sc.next();
    let mut ans = 0f64;
    for _ in 0..n {
        let p: f64 = sc.next::<i64>() as f64;
        let q: f64 = sc.next::<i64>() as f64;
        ans += q / p;
    }
    println!("{:.12}", ans);
}
