use math_algorithm_rs::Scanner;

// 入力: N X Y / 出力: 1..N のうち XまたはYの倍数の個数
// Rustポイント: 1..=n は閉区間（両端含む）
fn main() {
    let mut sc = Scanner::new();
    let n: usize = sc.next();
    let x: usize = sc.next();
    let y: usize = sc.next();
    let mut cnt = 0usize;
    for i in 1..=n {
        if i % x == 0 || i % y == 0 { cnt += 1; }
    }
    println!("{}", cnt);
}
