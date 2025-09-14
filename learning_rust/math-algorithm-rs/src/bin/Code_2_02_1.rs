fn main() {
    // 四則演算・剰余・abs・pow・sqrt のデモ
    // Rustポイント: 数値リ터ラルの型注釈（i32/f64など）とメソッド呼び出し
    println!("{}", 869 + 120);
    println!("{}", 869 - 120);
    println!("{}", 869 * 120);
    println!("{}", 869 / 120); // integer division

    println!("{}", 8 % 5);
    println!("{}", 869 % 120);

    println!("{}", (-45i32).abs());
    println!("{}", (15i32).abs());

    println!("{}", (10f64).powf(2.0) as i32);
    println!("{}", (3f64).powf(4.0) as i32);

    println!("{:.5}", (4f64).sqrt());
    println!("{:.5}", (2f64).sqrt());
}
