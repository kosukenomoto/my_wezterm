use math_algorithm_rs::Scanner;
use std::collections::VecDeque;

// 幅優先探索（BFS）：キューで最短距離を段階的に更新
// Rustポイント: VecDeque をキューとして push_back/pop_front。
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
    let mut dist = vec![-1i64; n + 1];
    let mut q = VecDeque::new();
    dist[1] = 0;
    q.push_back(1);
    while let Some(pos) = q.pop_front() {
        for &nex in &g[pos] {
            if dist[nex] == -1 {
                dist[nex] = dist[pos] + 1;
                q.push_back(nex);
            }
        }
    }
    for i in 1..=n { println!("{}", dist[i]); }
}
