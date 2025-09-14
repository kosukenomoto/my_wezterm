use math_algorithm_rs::Scanner;

// 入力: a b c / 出力: a+b+c
// Rustポイント:
// - 配列 [T;3] とイテレータ v.iter().sum() で合計
fn main() {
    let mut sc = Scanner::new();
    let v = [sc.next::<i64>(), sc.next::<i64>(), sc.next::<i64>()];
    let s: i64 = v.iter().sum();
    println!("{}", s);
}
