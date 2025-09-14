use std::sync::atomic::{AtomicI32, Ordering};

// Rustポイント:
// - 静的な可変グローバルはスレッド安全のため Atomic を使う（C++のグローバル変数に相当）
static CNT: AtomicI32 = AtomicI32::new(1000);

fn func1() -> i32 { 2021 }

fn func2(pos: i32) -> i32 {
    // fetch_add: 原子的にインクリメントし、直前の値を返す
    let c = CNT.fetch_add(1, Ordering::SeqCst) + 1;
    c + pos
}

fn main() {
    println!("{}", func1());
    println!("{}", func2(500));
    println!("{}", func2(500));
}
