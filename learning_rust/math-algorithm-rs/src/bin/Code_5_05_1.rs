use math_algorithm_rs::Scanner;

// 積の最大：4通り（a*c, a*d, b*c, b*d）を列挙して最大
// Rustポイント: i128 に拡張してオーバーフローを避ける。
fn main() {
    let mut sc = Scanner::new();
    let a: i128 = sc.next::<i64>() as i128;
    let b: i128 = sc.next::<i64>() as i128;
    let c: i128 = sc.next::<i64>() as i128;
    let d: i128 = sc.next::<i64>() as i128;
    let m = (a * c).max(a * d).max(b * c).max(b * d);
    println!("{}", m);
}
