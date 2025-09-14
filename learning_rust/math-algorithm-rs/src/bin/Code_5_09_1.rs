use math_algorithm_rs::Scanner;

// 貪欲：高額紙幣から順に使って枚数最小化
fn main() {
    let mut sc = Scanner::new();
    let mut n: i64 = sc.next();
    let mut ans = 0i64;
    while n >= 10000 { n -= 10000; ans += 1; }
    while n >= 5000 { n -= 5000; ans += 1; }
    while n >= 1000 { n -= 1000; ans += 1; }
    println!("{}", ans);
}
