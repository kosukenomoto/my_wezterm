use math_algorithm_rs::Scanner;

// フィボナッチの配列版（modは最後に取る）
// Rustポイント: 1始まりの配列をVecで再現、i128でオーバーフローを緩和。
fn main() {
    let mut sc = Scanner::new();
    let n: usize = sc.next();
    if n == 0 { println!("0"); return; }
    if n == 1 { println!("{}", 1 % 1_000_000_007); return; }
    let mut a = vec![0i128; n + 1];
    a[1] = 1;
    a[2] = 1;
    for i in 3..=n { a[i] = a[i - 1] + a[i - 2]; }
    let ans = (a[n] % 1_000_000_007) as i128;
    println!("{}", ans);
}
