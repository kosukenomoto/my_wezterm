use math_algorithm_rs::Scanner;

// 入力: N / 出力: N の2進表現
// Rustポイント:
// - Vec<u8> に下位ビットからpush → reverseで上位桁に
// - イテレータ + map + collect で String に変換
fn main() {
    let mut sc = Scanner::new();
    let mut n: u64 = sc.next();
    if n == 0 { println!("0"); return; }
    let mut bits = Vec::new();
    while n >= 1 {
        bits.push((n % 2) as u8);
        n /= 2;
    }
    bits.reverse();
    let s: String = bits.into_iter().map(|b| if b == 0 { '0' } else { '1' }).collect();
    println!("{}", s);
}
