use math_algorithm_rs::Scanner;

// 深さ優先探索（明示的スタック使用）
// Rustポイント: Vec をスタックとして push/pop する。
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
    let mut st = Vec::<usize>::new();
    vis[1] = true;
    st.push(1);
    while let Some(pos) = st.pop() { // Option から取り出し
        for &nex in &g[pos] {
            if !vis[nex] {
                vis[nex] = true;
                st.push(nex);
            }
        }
    }
    let mut ok = true;
    for i in 1..=n { if !vis[i] { ok = false; } }
    if ok { println!("The graph is connected."); }
    else { println!("The graph is not connected."); }
}
