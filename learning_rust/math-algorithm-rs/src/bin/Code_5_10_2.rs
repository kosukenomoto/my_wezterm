use math_algorithm_rs::{Scanner, yes_no};

// 不等式の安全な判定：平方や積でオーバーフローしないよう i128 を使用
fn main() {
    let mut sc = Scanner::new();
    let a: i128 = sc.next::<i64>() as i128;
    let b: i128 = sc.next::<i64>() as i128;
    let c: i128 = sc.next::<i64>() as i128;
    let t = c - a - b;
    let cond = if t < 0 { false } else { 4 * a * b < t * t };
    yes_no(cond);
}
