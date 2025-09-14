use math_algorithm_rs::Scanner;

const MOD: i64 = 1_000_000_007;

// Σ A[i] * C(N-1, i-1)（mod）を前計算した階乗で計算
fn modpow(a: i64, b: i64, m: i64) -> i64 {
    let mut p = a % m; let mut ans = 1i64;
    for i in 0..60 { if ((b >> i) & 1) != 0 { ans = (ans * p) % m; } p = (p * p) % m; }
    ans
}
fn division(a: i64, b: i64, m: i64) -> i64 { (a * modpow(b, m - 2, m)) % m }
fn ncr(n: usize, r: usize, fact: &Vec<i64>) -> i64 {
    let denom = (fact[r] as i128 * fact[n - r] as i128 % MOD as i128) as i64;
    division(fact[n], denom, MOD)
}

fn main() {
    let mut sc = Scanner::new();
    let n: usize = sc.next();
    let mut a = vec![0i64; n + 1];
    for i in 1..=n { a[i] = sc.next::<i64>(); }
    let mut fact = vec![0i64; 200_000 + 1];
    fact[0] = 1;
    for i in 1..=200_000 { fact[i] = (i as i64 * fact[i - 1]) % MOD; }
    let mut ans = 0i64;
    for i in 1..=n { ans = (ans + (a[i] % MOD) * ncr(n - 1, i - 1, &fact)) % MOD; }
    println!("{}", ans);
}
