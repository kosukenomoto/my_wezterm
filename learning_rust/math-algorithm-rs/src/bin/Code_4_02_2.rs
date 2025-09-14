use math_algorithm_rs::Scanner;

// 差分配列：B[L]+=X, B[R+1]-=X として変化を記録→比較記号を出力
// Rustポイント: 末尾+1にアクセスするので長さは N+2 を確保。
fn main() {
    let mut sc = Scanner::new();
    let n: usize = sc.next();
    let q: usize = sc.next();
    let mut b = vec![0i64; n + 2]; // R+1 access allowed
    for _ in 0..q {
        let l: usize = sc.next();
        let r: usize = sc.next();
        let x: i64 = sc.next();
        b[l] += x;
        b[r + 1] -= x;
    }
    // i=2..=n で B[i] の符号に応じて記号を構築
    let mut out = String::new();
    for i in 2..=n {
        if b[i] > 0 { out.push('<'); }
        else if b[i] == 0 { out.push('='); }
        else { out.push('>'); }
    }
    println!("{}", out);
}
