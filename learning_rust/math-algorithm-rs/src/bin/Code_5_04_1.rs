use math_algorithm_rs::Scanner;

// 三重ループの数え上げ：条件を満たさない個数（bad）を引いて答え
// Rustポイント: max/min はメソッド（a.max(b)/a.min(b)）。
fn main() {
    let mut sc = Scanner::new();
    let n: i64 = sc.next();
    let k: i64 = sc.next();
    let mut bad: i64 = 0;
    for a in 1..=n {
        let bl = (a - (k - 1)).max(1);
        let br = (a + (k - 1)).min(n);
        for b in bl..=br {
            let cl = (a - (k - 1)).max(1);
            let cr = (a + (k - 1)).min(n);
            for c in cl..=cr { if (b - c).abs() <= k - 1 { bad += 1; } }
        }
    }
    let total = n * n * n;
    println!("{}", total - bad);
}
