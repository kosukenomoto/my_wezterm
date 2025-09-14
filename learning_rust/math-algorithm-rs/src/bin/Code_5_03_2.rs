use math_algorithm_rs::Scanner;

// 条件判定：和の偶奇と上限Kをチェック
// Rustポイント: (sum%2)!=(k%2) で偶奇が一致するか判定。
fn main() {
    let mut sc = Scanner::new();
    let n: usize = sc.next();
    let k: i64 = sc.next();
    let mut sum: i64 = 0;
    for _ in 0..n { sum += sc.next::<i64>(); }
    if (sum % 2) != (k % 2) { println!("No"); }
    else if sum > k { println!("No"); }
    else { println!("Yes"); }
}
