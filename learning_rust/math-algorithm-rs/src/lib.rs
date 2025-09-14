use std::io::{self, Read};

// Scanner: 標準入力を一括で読み、空白区切りで値を取り出す簡易スキャナ
// - 競技プログラミングでよくある「高速入力」の簡易版です
// - new() で標準入力を全部読み込み、next::<T>() で任意型にパースします
pub struct Scanner {
    buf: Vec<u8>,   // 読み込んだ生バイト列
    idx: usize,     // 次に読む位置（オフセット）
}

impl Scanner {
    pub fn new() -> Self {
        let mut input = String::new();
        io::stdin().read_to_string(&mut input).unwrap();
        Self { buf: input.into_bytes(), idx: 0 }
    }
    fn is_whitespace(b: u8) -> bool { matches!(b, b' ' | b'\n' | b'\r' | b'\t') }
    pub fn next<T: std::str::FromStr>(&mut self) -> T {
        // 連続する空白をスキップ
        while self.idx < self.buf.len() && Self::is_whitespace(self.buf[self.idx]) { self.idx += 1; }
        let start = self.idx;
        // 次の空白までをトークンとして切り出す
        while self.idx < self.buf.len() && !Self::is_whitespace(self.buf[self.idx]) { self.idx += 1; }
        std::str::from_utf8(&self.buf[start..self.idx]).unwrap().parse().ok().unwrap()
    }
}

// Yes/No の簡易出力ヘルパ
pub fn yes_no(cond: bool) { if cond { println!("Yes"); } else { println!("No"); } }

// Chapter 3: 数論・補助関数（C++の関数断片をRustに移植）
pub fn is_prime_naive(n: i64) -> bool {
    if n < 2 { return false; }
    for i in 2..=n - 1 { if n % i == 0 { return false; } }
    true
}

pub fn is_prime_sqrt(n: i64) -> bool {
    if n < 2 { return false; }
    let mut i = 2i64;
    while i * i <= n { if n % i == 0 { return false; } i += 1; }
    true
}

pub fn gcd_bruteforce(a: i64, b: i64) -> i64 {
    let m = a.min(b);
    let mut ans = 0;
    for i in 1..=m { if a % i == 0 && b % i == 0 { ans = i; } }
    ans
}

pub fn gcd_euclid_iter(mut a: i64, mut b: i64) -> i64 {
    while a >= 1 && b >= 1 { if a < b { b %= a; } else { a %= b; } }
    if a >= 1 { a } else { b }
}

pub fn gcd_euclid_rec(a: i64, b: i64) -> i64 { if b == 0 { a } else { gcd_euclid_rec(b, a % b) } }

#[allow(dead_code)]
pub fn bad_recursive_func(n: i64) -> i64 {
    // 故意にベースケースがない再帰（教材用）。呼ぶと再帰が止まらずスタックオーバーフローします。
    bad_recursive_func(n - 1) * n
}
