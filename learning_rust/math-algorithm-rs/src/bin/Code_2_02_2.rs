use math_algorithm_rs::Scanner;

// 入力: a b / 出力: AND, OR, XOR
// Rustポイント: ビット演算は C++ と同じ記号（&,|,^）
fn main() {
    let mut sc = Scanner::new();
    let a: i64 = sc.next();
    let b: i64 = sc.next();
    println!("{}", a & b);
    println!("{}", a | b);
    println!("{}", a ^ b);
}
