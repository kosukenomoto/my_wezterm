use math_algorithm_rs::Scanner;

// 0-1ナップサック（典型DP）：dp[i][j] = i番目までで重さjのときの価値最大
// Rustポイント: 2次元Vecの初期化、maxで遷移、usizeとi64の混在に注意。
fn main() {
    let mut sc = Scanner::new();
    let n: usize = sc.next();
    let wmax: usize = sc.next();
    let mut w = vec![0usize; n+1];
    let mut v = vec![0i64; n+1];
    for i in 1..=n { w[i] = sc.next::<i64>() as usize; v[i] = sc.next::<i64>(); }
    let neg_inf: i64 = -(1i64 << 60);
    let mut dp = vec![vec![neg_inf; wmax + 1]; n + 1];
    dp[0][0] = 0;
    for i in 1..=n {
        for j in 0..=wmax {
            if j < w[i] { dp[i][j] = dp[i - 1][j]; }
            if j >= w[i] {
                let take = dp[i - 1][j - w[i]] + v[i];
                let notake = dp[i - 1][j];
                dp[i][j] = notake.max(take);
            }
        }
    }
    let mut ans = 0i64;
    for j in 0..=wmax { ans = ans.max(dp[n][j]); }
    println!("{}", ans);
}
