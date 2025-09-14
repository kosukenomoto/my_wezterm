use math_algorithm_rs::Scanner;

// 括弧列判定：開きで+1、閉じで-1、途中で負にならず、最後に0
// Rustポイント: 文字列→バイト列（as_bytes）で1文字ずつ判定。
fn main() {
    let mut sc = Scanner::new();
    let n: usize = sc.next();
    let s: String = sc.next::<String>();
    let bytes = s.as_bytes();
    let mut depth: i64 = 0;
    for i in 0..n {
        if bytes[i] == b'(' { depth += 1; }
        if bytes[i] == b')' { depth -= 1; }
        if depth < 0 { println!("No"); return; }
    }
    if depth == 0 { println!("Yes"); } else { println!("No"); }
}
