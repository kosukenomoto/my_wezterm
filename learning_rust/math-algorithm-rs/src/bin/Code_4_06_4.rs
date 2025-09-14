use math_algorithm_rs::Scanner;

// 二分累乗（繰り返し二乗法）で a^b mod を高速計算
fn modpow(a: i64, b: i64, m: i64) -> i64 {
    let mut p = a % m;
    let mut ans: i64 = 1;
    for i in 0..60 {
        if ((b >> i) & 1) != 0 { ans = (ans * p) % m; }
        p = (p * p) % m;
    }
    ans
}

const MOD: i64 = 1_000_000_007;

fn main() {
    let mut sc = Scanner::new();
    let a: i64 = sc.next();
    let b: i64 = sc.next();
    println!("{}", modpow(a, b, MOD));
}
