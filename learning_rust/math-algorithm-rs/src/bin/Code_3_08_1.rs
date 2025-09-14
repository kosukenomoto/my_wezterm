use math_algorithm_rs::{Scanner, yes_no};

// 二分探索：ソート→左右ポインタで探索
// Rustポイント: ループ条件と添字はi64にして境界を扱いやすく。
fn main() {
    let mut sc = Scanner::new();
    let n: usize = sc.next();
    let x: i64 = sc.next();
    let mut a = vec![0i64; n];
    for i in 0..n { a[i] = sc.next::<i64>(); }
    a.sort();
    let mut left = 0i64;
    let mut right = n as i64 - 1;
    let mut found = false;
    while left <= right {
        let mid = (left + right) / 2;
        let val = a[mid as usize];
        if val == x { found = true; break; }
        if val > x { right = mid - 1; } else { left = mid + 1; }
    }
    yes_no(found);
}
