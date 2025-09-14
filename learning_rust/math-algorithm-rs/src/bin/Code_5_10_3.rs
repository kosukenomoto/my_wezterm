use math_algorithm_rs::Scanner;

// 4重ループ探索：a≤b≤c≤d で和と積が一致するものがあるか
// Rustポイント: 積はi128に拡張してオーバーフロー回避。
fn main() {
    let mut sc = Scanner::new();
    let n: i64 = sc.next();
    let x: i128 = sc.next::<i64>() as i128;
    let y: i128 = sc.next::<i64>() as i128;
    for a in 1..=n { for b in a..=n { for c in b..=n { for d in c..=n {
        if (a + b + c + d) as i128 == x && (a as i128) * (b as i128) * (c as i128) * (d as i128) == y {
            println!("Yes");
            return;
        }
    }}}}
    println!("No");
}
