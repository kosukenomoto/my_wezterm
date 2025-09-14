use math_algorithm_rs::Scanner;

// 入力: N / A1..AN / 出力: 昇順に整列して出力
// Rustポイント: Vec<T>::sort() はin-place。イテレータで出力可能。
fn main() {
    let mut sc = Scanner::new();
    let n: usize = sc.next();
    let mut a = vec![0i64; n];
    for i in 0..n { a[i] = sc.next::<i64>(); }
    a.sort();
    for x in a { println!("{}", x); }
}
