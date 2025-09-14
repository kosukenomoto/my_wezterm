use math_algorithm_rs::Scanner;

// 入力: N / 出力: N の約数（小さい方から）
// Rustポイント: while ループと i64 の演算。平方根まで試す典型手法。
fn main() {
    let mut sc = Scanner::new();
    let n: i64 = sc.next();
    let mut i = 1i64;
    while i * i <= n {
        if n % i == 0 {
            println!("{}", i);
            if i != n / i { println!("{}", n / i); }
        }
        i += 1;
    }
}
