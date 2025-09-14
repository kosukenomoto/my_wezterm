use math_algorithm_rs::Scanner;

// 累積和：B[i]=A[1]+..+A[i] として区間和をO(1)で答える
// Rustポイント: 1始まりの配列をVecで再現（添字に注意）。
fn main() {
    let mut sc = Scanner::new();
    let n: usize = sc.next();
    let q: usize = sc.next();
    let mut a = vec![0i64; n+1]; // 1-based for clarity with prefix
    for i in 1..=n { a[i] = sc.next::<i64>(); }
    let mut b = vec![0i64; n+1];
    for i in 1..=n { b[i] = b[i-1] + a[i]; }
    for _ in 0..q {
        let l: usize = sc.next();
        let r: usize = sc.next();
        println!("{}", b[r] - b[l-1]);
    }
}
