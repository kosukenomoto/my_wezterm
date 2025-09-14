use math_algorithm_rs::Scanner;

// Frog DP（典型DP）：dp[i] = min(dp[i-1]+|h[i]-h[i-1]|, dp[i-2]+|h[i]-h[i-2]|)
// Rustポイント: VecでDP配列を用意。abs()はi64のメソッド。
fn main() {
    let mut sc = Scanner::new();
    let n: usize = sc.next();
    let mut h = vec![0i64; n];
    for i in 0..n { h[i] = sc.next::<i64>(); }
    let mut dp = vec![0i64; n];
    if n >= 2 { dp[1] = (h[1] - h[0]).abs(); }
    for i in 2..n {
        let v1 = dp[i - 1] + (h[i - 1] - h[i]).abs();
        let v2 = dp[i - 2] + (h[i - 2] - h[i]).abs();
        dp[i] = v1.min(v2);
    }
    println!("{}", dp[n - 1]);
}
