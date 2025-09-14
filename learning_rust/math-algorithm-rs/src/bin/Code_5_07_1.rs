use math_algorithm_rs::Scanner;

// 重み付き和：係数は1始まりの式を0始まりに変換して使用
// Rustポイント: iter().enumerate() で (index, &value) を得る。
fn main() {
    let mut sc = Scanner::new();
    let n: usize = sc.next();
    let mut a = vec![0_i64; n];
    for i in 0..n { a[i] = sc.next::<i64>(); }
    // coef(1-based i) = -N + 2*i - 1
    // i0 = i-1 とすると coef = -N + 2*i0 + 1
    let ans: i64 = a.iter().enumerate().map(|(i0, &x)| x * (-(n as i64) + 2 * i0 as i64 + 1)).sum();
    println!("{}", ans);
}
