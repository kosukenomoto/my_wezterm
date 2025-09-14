use math_algorithm_rs::Scanner;

// 入力: N / B1..BN / R1..RN / 出力: 期待値の合計（小数12桁）
// Rustポイント: 整数→浮動小数点の明示キャスト（as f64）。
fn main() {
    let mut sc = Scanner::new();
    let n: usize = sc.next();
    let mut blue = 0f64;
    let mut red = 0f64;
    let mut b = vec![0i64; n];
    let mut r = vec![0i64; n];
    for i in 0..n { b[i] = sc.next::<i64>(); }
    for i in 0..n { r[i] = sc.next::<i64>(); }
    for i in 0..n {
        blue += b[i] as f64 / n as f64;
        red += r[i] as f64 / n as f64;
    }
    println!("{:.12}", blue + red);
}
