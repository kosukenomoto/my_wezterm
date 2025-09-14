use math_algorithm_rs::Scanner;

// エラトステネスの篩：素数判定を配列で管理
// Rustポイント: whileで i*i<=N、内側は while で倍数を潰す。
fn main() {
    let mut sc = Scanner::new();
    let n: usize = sc.next();
    let mut prime = vec![false; n + 1];
    for i in 2..=n { prime[i] = true; }
    let mut i = 2usize;
    while i * i <= n {
        if prime[i] {
            let mut x = i * 2;
            while x <= n { prime[x] = false; x += i; }
        }
        i += 1;
    }
    for i in 2..=n { if prime[i] { println!("{}", i); } }
}
