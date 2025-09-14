use math_algorithm_rs::Scanner;

// 入力: N / A1..AN / 出力: 5要素の和=1000 となる組の個数
// Rustポイント: 0始まりのインデックスと半開区間のネストループ。
fn main() {
    let mut sc = Scanner::new();
    let n: usize = sc.next();
    let mut a = vec![0i64; n];
    for i in 0..n { a[i] = sc.next::<i64>(); }
    let mut ans = 0i64;
    for i in 0..n {
        for j in (i+1)..n {
            for k in (j+1)..n {
                for l in (k+1)..n {
                    for m in (l+1)..n {
                        if a[i] + a[j] + a[k] + a[l] + a[m] == 1000 { ans += 1; }
                    }
                }
            }
        }
    }
    println!("{}", ans);
}
