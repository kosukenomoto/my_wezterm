use math_algorithm_rs::Scanner;

const MOD: i64 = 1_000_000_007;

// フィボナッチ（0始まりDP）：a[0]=0, a[1]=1、以降は前2つの和をmod付きで計算
fn main() {
    let mut sc = Scanner::new();
    let n: usize = sc.next();
    if n == 0 { println!("0"); return; }
    if n == 1 { println!("1"); return; }
    let mut a = vec![0_i64; n + 1];
    a[0] = 0;
    a[1] = 1;
    for i in 2..=n { a[i] = (a[i - 1] + a[i - 2]) % MOD; }
    println!("{}", a[n]);
}
