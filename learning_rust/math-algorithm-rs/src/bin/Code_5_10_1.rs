use math_algorithm_rs::{Scanner, yes_no};

// 実数計算：sqrt(a)+sqrt(b) < sqrt(c) か
// Rustポイント: f64 で読み、sqrt() はメソッド。
fn main() {
    let mut sc = Scanner::new();
    let a: f64 = sc.next();
    let b: f64 = sc.next();
    let c: f64 = sc.next();
    let cond = a.sqrt() + b.sqrt() < c.sqrt();
    yes_no(cond);
}
