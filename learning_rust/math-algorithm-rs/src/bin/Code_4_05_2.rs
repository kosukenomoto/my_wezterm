use math_algorithm_rs::Scanner;

// 深さ優先探索（再帰）で連結判定
// Rustポイント: &Vec<Vec<usize>> と &mut [bool] で借用を明示。
fn dfs(pos: usize, g: &Vec<Vec<usize>>, vis: &mut [bool]) {
    vis[pos] = true;
    for &nex in &g[pos] { if !vis[nex] { dfs(nex, g, vis); } }
}

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
    let mut vis = vec![false; n + 1];
    dfs(1, &g, &mut vis);
    let mut ok = true;
    for i in 1..=n { if !vis[i] { ok = false; } }
    if ok { println!("The graph is connected."); }
    else { println!("The graph is not connected."); }
}
