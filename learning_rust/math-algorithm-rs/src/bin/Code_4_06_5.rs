use math_algorithm_rs::Scanner;

const MOD: i64 = 1_000_000_007;

// 逆元を使った割り算: a/b ≡ a * b^(m-2) (mod m)
fn modpow(a: i64, b: i64, m: i64) -> i64 {
    let mut p = a % m; let mut ans = 1i64;
    for i in 0..60 { if ((b >> i) & 1) != 0 { ans = (ans * p) % m; } p = (p * p) % m; }
    ans
}
fn division(a: i64, b: i64, m: i64) -> i64 { (a * modpow(b, m - 2, m)) % m }

fn main() {
    let mut sc = Scanner::new();
    let x: i64 = sc.next();
    let y: i64 = sc.next();
    let mut bunshi = 1i64; // (X+Y)!
    let mut bunbo = 1i64;  // X! * Y!
    for i in 1..=x + y { bunshi = (bunshi * (i % MOD)) % MOD; }
    for i in 1..=x { bunbo = (bunbo * (i % MOD)) % MOD; }
    for i in 1..=y { bunbo = (bunbo * (i % MOD)) % MOD; }
    println!("{}", division(bunshi, bunbo, MOD));
}
