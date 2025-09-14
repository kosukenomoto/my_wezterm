use math_algorithm_rs::Scanner;

// 商の問題：区間内に t の倍数が2個以上ある最大の t
// Rustポイント: 天井/床の整数除算をそのまま計算（i64）。
fn shou_mondai(a: i64, b: i64, t: i64) -> bool {
    let cl = (a + t - 1) / t; // ceil(a/t)
    let cr = b / t;           // floor(b/t)
    cr - cl >= 1
}

fn main() {
    let mut sc = Scanner::new();
    let a: i64 = sc.next();
    let b: i64 = sc.next();
    let mut ans = 0i64;
    for i in 1..=b { if shou_mondai(a, b, i) { ans = i; } }
    println!("{}", ans);
}
