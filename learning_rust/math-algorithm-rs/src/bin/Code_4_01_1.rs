use math_algorithm_rs::Scanner;

// 点と線分の距離：内積でパターン判定、面積/底辺で距離
// Rustポイント: 整数演算でベクトル成分、平方根のみf64にする。
fn main() {
    let mut sc = Scanner::new();
    let ax: i64 = sc.next();
    let ay: i64 = sc.next();
    let bx: i64 = sc.next();
    let by: i64 = sc.next();
    let cx: i64 = sc.next();
    let cy: i64 = sc.next();

    let bax = ax - bx; let bay = ay - by;
    let bcx = cx - bx; let bcy = cy - by;
    let cax = ax - cx; let cay = ay - cy;
    let cbx = bx - cx; let cby = by - cy;

    let mut pattern = 2;
    if bax * bcx + bay * bcy < 0 { pattern = 1; }
    if cax * cbx + cay * cby < 0 { pattern = 3; }

    let ans = if pattern == 1 {
        ((bax * bax + bay * bay) as f64).sqrt()
    } else if pattern == 3 {
        ((cax * cax + cay * cay) as f64).sqrt()
    } else {
        let s = (bax * bcy - bay * bcx).abs() as f64;
        let bcl = ((bcx * bcx + bcy * bcy) as f64).sqrt();
        s / bcl
    };
    println!("{:.12}", ans);
}
