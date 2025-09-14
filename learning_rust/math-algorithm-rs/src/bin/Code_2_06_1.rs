use math_algorithm_rs::Scanner;

// 入力: N S / A1..AN。2^N 個の部分集合をbitで全探索し、和=Sが存在するか判定
// Rustポイント:
// - ビットマスクは u64 を使用し、(mask >> j) & 1 で j 桁目を見る
// - Vec<i64> は可変長配列（C++のvector相当）
fn main() {
    let mut sc = Scanner::new();
    let n: usize = sc.next();
    let s: i64 = sc.next();
    let mut a = vec![0_i64; n];
    for i in 0..n { a[i] = sc.next::<i64>(); }

    for mask in 0_u64..(1_u64 << n) {
        let mut sum: i64 = 0;
        for j in 0..n {
            if ((mask >> j) & 1) != 0 { sum += a[j]; }
        }
        if sum == s { println!("Yes"); return; }
    }
    println!("No");
}
