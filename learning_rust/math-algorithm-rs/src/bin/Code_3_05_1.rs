// 円周率のモンテカルロ推定（外部クレート不使用）
// Rustポイント: 簡易LCG（線形合同法）で乱数を生成し、f64に正規化。

fn lcg_next(x: &mut u64) -> f64 {
    // Constants from Numerical Recipes (not great, but fine for demo)
    *x = x.wrapping_mul(1664525).wrapping_add(1013904223);
    let v = (*x >> 11) as f64; // use high bits
    v / ((1u64 << 53) as f64)
}

fn main() {
    let n: usize = 10000; // trials
    let mut m: usize = 0; // points in quarter circle
    let mut seed: u64 = 88172645463393265; // fixed seed
    for _ in 0..n {
        let px = lcg_next(&mut seed);
        let py = lcg_next(&mut seed);
        if px * px + py * py <= 1.0 { m += 1; }
    }
    println!("{:.12}", 4.0 * (m as f64) / (n as f64));
}
