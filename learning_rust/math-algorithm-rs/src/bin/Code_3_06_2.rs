use math_algorithm_rs::Scanner;

// 選択ソート（0始まり配列）
// Rustポイント: Vec::swap(i,j) で要素の入替。範囲は [i+1, n)。
fn main() {
    let mut sc = Scanner::new();
    let n: usize = sc.next();
    let mut a = vec![0i64; n];
    for i in 0..n { a[i] = sc.next::<i64>(); }
    for i in 0..n-1 {
        let mut min_idx = i;
        for j in (i+1)..n { if a[j] < a[min_idx] { min_idx = j; } }
        a.swap(i, min_idx);
    }
    for x in a { println!("{}", x); }
}
