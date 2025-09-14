use math_algorithm_rs::Scanner;

// 2x2行列の累乗でFibonacciを計算（a=[[1,1],[1,0]]）
// Rustポイント: 小さな行列を配列 [[i64;2];2] で表現し、積と累乗を関数化。
#[derive(Clone, Copy)]
struct Matrix { p: [[i64; 2]; 2] }

fn mul(a: Matrix, b: Matrix) -> Matrix {
    let mut c = Matrix { p: [[0; 2]; 2] };
    for i in 0..2 { for k in 0..2 { for j in 0..2 {
        c.p[i][j] = (c.p[i][j] + a.p[i][k] * b.p[k][j]) % 1_000_000_000;
    }}}
    c
}

fn power(mut a: Matrix, n: i64) -> Matrix {
    let mut flag = false;
    let mut q = Matrix { p: [[0; 2]; 2] };
    for i in 0..60 {
        if ((n >> i) & 1) != 0 { if !flag { q = a; flag = true; } else { q = mul(q, a); } }
        a = mul(a, a);
    }
    q
}

fn main() {
    let mut sc = Scanner::new();
    let n: i64 = sc.next();
    let a = Matrix { p: [[1, 1], [1, 0]] };
    let b = power(a, n - 1);
    println!("{}", (b.p[1][0] + b.p[1][1]) % 1_000_000_000);
}
