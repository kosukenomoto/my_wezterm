use math_algorithm_rs::Scanner;

const MOD: i64 = 1_000_000_007;

// 反復乗算で a^b mod を計算（愚直法）
fn main() {
    let mut sc = Scanner::new();
    let a: i64 = sc.next();
    let b: i64 = sc.next();
    let mut ans: i64 = 1;
    for _ in 1..=b { ans = (ans * (a % MOD)) % MOD; }
    println!("{}", ans);
}
