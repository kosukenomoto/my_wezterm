use math_algorithm_rs::Scanner;

// 無向グラフの隣接リストを構築して出力
// Rustポイント: Vec<Vec<usize>> で可変長の隣接配列を表現。
fn main() {
    let mut sc = Scanner::new();
    let n: usize = sc.next();
    let m: usize = sc.next();
    let mut g = vec![Vec::<usize>::new(); n + 1];
    for _ in 0..m {
        let a: usize = sc.next();
        let b: usize = sc.next();
        g[a].push(b);
        g[b].push(a);
    }
    for i in 1..=n {
        print!("{}: {{", i);
        for (j, v) in g[i].iter().enumerate() {
            if j >= 1 { print!(","); }
            print!("{}", v);
        }
        println!("}}");
    }
}
