use math_algorithm_rs::Scanner;

// 最小長方形面積：候補境界を全探索（座標のみに限定）
// Rustポイント: &Vec<T> の不変参照で関数に渡す（コピーを避ける）。
fn count_points(xs: &Vec<i64>, ys: &Vec<i64>, lx: i64, rx: i64, ly: i64, ry: i64) -> usize {
    let mut cnt = 0usize;
    for i in 0..xs.len() {
        if lx <= xs[i] && xs[i] <= rx && ly <= ys[i] && ys[i] <= ry { cnt += 1; }
    }
    cnt
}

fn main() {
    let mut sc = Scanner::new();
    let n: usize = sc.next();
    let k: usize = sc.next();
    let mut xs = vec![0i64; n];
    let mut ys = vec![0i64; n];
    for i in 0..n { xs[i] = sc.next::<i64>(); ys[i] = sc.next::<i64>(); }
    let mut ans: i128 = (1i128) << 62; // 十分大きな初期値
    for i in 0..n { for j in 0..n { for p in 0..n { for q in 0..n {
        let lx = xs[i]; let rx = xs[j]; let ly = ys[p]; let ry = ys[q];
        if count_points(&xs, &ys, lx, rx, ly, ry) >= k {
            let area = (rx - lx) as i128 * (ry - ly) as i128;
            if area < ans { ans = area; }
        }
    }}}}
    println!("{}", ans);
}
