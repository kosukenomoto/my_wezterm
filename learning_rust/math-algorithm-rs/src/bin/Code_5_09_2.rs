use math_algorithm_rs::Scanner;

// 区間スケジューリング（貪欲）：現時刻以降で終了時刻最小の区間を貪欲に選ぶ
// Rustポイント: ループで最小終了時刻を毎回探索（C++のminと同等にmin()使用）。
fn main() {
    let mut sc = Scanner::new();
    let n: usize = sc.next();
    let mut l = vec![0i32; n+1];
    let mut r = vec![0i32; n+1];
    for i in 1..=n { l[i] = sc.next::<i64>() as i32; r[i] = sc.next::<i64>() as i32; }
    let mut current_time: i32 = 0;
    let mut ans = 0;
    loop {
        let mut min_endtime = 1_000_000i32;
        for i in 1..=n { if l[i] >= current_time { min_endtime = min_endtime.min(r[i]); } }
        if min_endtime == 1_000_000 { break; }
        current_time = min_endtime;
        ans += 1;
    }
    println!("{}", ans);
}
