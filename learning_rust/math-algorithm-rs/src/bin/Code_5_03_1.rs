use math_algorithm_rs::{Scanner, yes_no};

// 偶奇判定：n%2==0 なら Yes
fn main() {
    let mut sc = Scanner::new();
    let n: i64 = sc.next();
    yes_no(n % 2 == 0);
}
