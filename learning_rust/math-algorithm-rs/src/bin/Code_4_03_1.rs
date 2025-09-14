// ニュートン法で sqrt(2) の近似。接線の式から次の解を更新。
fn main() {
    let r = 2.0f64;
    let mut a = 2.0f64;
    for i in 1..=5 {
        let zx = a;
        let zy = a * a;
        let s_a = 2.0 * zx;
        let s_b = zy - s_a * zx;
        let next_a = (r - s_b) / s_a; // x切片
        println!("Step #{}: a = {:.12} -> {:.12}", i, a, next_a);
        a = next_a;
    }
}
