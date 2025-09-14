use math_algorithm_rs::Scanner;

// 分割統治で区間 [l,r) の総和を計算（再帰で左右に分割）
// Rustポイント: スライス &[i64] で不変借用しつつ、添字で参照。
fn solve(a: &[i64], l: usize, r: usize) -> i64 {
    if r - l == 1 { return a[l]; }
    let m = (l + r) / 2;
    let s1 = solve(a, l, m);
    let s2 = solve(a, m, r);
    s1 + s2
}

fn main() {
    let mut sc = Scanner::new();
    let n: usize = sc.next();
    let mut a = vec![0i64; n];
    for i in 0..n { a[i] = sc.next::<i64>(); }
    let ans = solve(&a, 0, n);
    println!("{}", ans);
}
