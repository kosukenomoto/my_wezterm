use math_algorithm_rs::Scanner;

// 入力: N S / 出力: 1..N の i,j で i+j<=S の組数
// Rustポイント: usize と i64 の加算はキャストが必要（型安全）
fn main() {
    let mut sc = Scanner::new();
    let n: usize = sc.next();
    let s: i64 = sc.next();
    let mut ans: i64 = 0;
    for i in 1..=n {
        for j in 1..=n {
            if (i as i64) + (j as i64) <= s { ans += 1; }
        }
    }
    println!("{}", ans);
}
