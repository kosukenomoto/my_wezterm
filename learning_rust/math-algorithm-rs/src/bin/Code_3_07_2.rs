use math_algorithm_rs::Scanner;

// DPでフィボナッチ数列（ベースケース i<=1 は1）
// Rustポイント: 0..=n は閉区間ループ、dpはVec<i64>。
fn main() {
    let mut sc = Scanner::new();
    let n: usize = sc.next();
    let mut dp = vec![0i64; n + 1];
    for i in 0..=n {
        if i <= 1 { dp[i] = 1; }
        else { dp[i] = dp[i - 1] + dp[i - 2]; }
    }
    println!("{}", dp[n]);
}
