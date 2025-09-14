use math_algorithm_rs::Scanner;

// 入力: N / 出力: 5+N
// Rustポイント:
// - Scannerで標準入力からi64を読み取る
// - println!マクロで出力（{}はフォーマット埋め込み）
fn main() {
    let mut sc = Scanner::new();
    let n: i64 = sc.next();
    println!("{}", 5 + n);
}
