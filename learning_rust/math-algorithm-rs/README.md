## math-algorithm-rs

E869120/math-algorithm-book（codes/cpp）のサンプルをRustへ移植したものです。アルゴリズムは原著のまま、Rustらしさを適用しています。

## 実行方法
- Rust をインストール（rustup 推奨）: `curl https://sh.rustup.rs -sSf | sh` → `source ~/.cargo/env`
- このディレクトリで実行: `cargo run --bin <バイナリ名> < 入力ファイル` または `echo "..." | cargo run --bin <バイナリ名>`
- 例: `echo "3 5\n2 3 4" | cargo run --bin Code_2_06_1`

### サンプル入力で手早く動かす
- 用意済みのサンプル入力を使う場合は次を実行:
  - `./scripts/run_sample.sh Code_3_07_1`
- サンプルは `samples/<バイナリ名>.in` に配置されています（現在 50+ 本）。
- 一覧: `ls samples | sed 's/\.in$//'`

## 各バイナリの入力フォーマットと実行例
章2
- Code_2_01_1: 入力: `N` 例: `echo "7" | cargo run --bin Code_2_01_1`
- Code_2_01_2: 入力: `a b c` 例: `echo "1 2 3" | cargo run --bin Code_2_01_2`
- Code_2_01_3: 入力: `N` 改行 `A1 ... AN` 例: `echo "3\n10 20 30" | cargo run --bin Code_2_01_3`
- Code_2_01_4: 入力: `N`（2進表現を出力）例: `echo "13" | cargo run --bin Code_2_01_4`
- Code_2_02_1: 入力なし（四則/剰余/abs/pow/sqrt のデモ）例: `cargo run --bin Code_2_02_1`
- Code_2_02_2: 入力: `a b`（AND/OR/XOR を出力）例: `echo "5 3" | cargo run --bin Code_2_02_2`
- Code_2_03_1: 入力なし（関数/グローバルのデモ）例: `cargo run --bin Code_2_03_1`
- Code_2_04_1: 入力: `N`（2N+3）例: `echo "4" | cargo run --bin Code_2_04_1`
- Code_2_04_2: 入力: `N X Y`（1..NのうちXまたはYの倍数数）例: `echo "10 3 4" | cargo run --bin Code_2_04_2`
- Code_2_04_3: 入力: `N S`（1..Nのi,jでi+j<=Sの個数）例: `echo "3 4" | cargo run --bin Code_2_04_3`
- Code_2_06_1: 入力: `N S` 改行 `A1 ... AN`（部分和）例: `echo "3 5\n2 3 4" | cargo run --bin Code_2_06_1`

章3
- Code_3_01_3: 入力: `N`（約数列挙）例: `echo "12" | cargo run --bin Code_3_01_3`
- Code_3_03_1: 入力: `N` 改行 `A1 ... AN`（5要素和=1000の個数）例: `echo "5\n100 200 300 400 0" | cargo run --bin Code_3_03_1`
- Code_3_04_1: 入力: `N` 改行 `B1..BN` 改行 `R1..RN`（期待値）例: `echo "3\n1 2 3\n3 2 1" | cargo run --bin Code_3_04_1`
- Code_3_04_2: 入力: `N` 改行 `P1 Q1`..（ΣQ/P）例: `echo "2\n2 1\n4 1" | cargo run --bin Code_3_04_2`
- Code_3_05_1: 入力なし（円周率のモンテカルロ）例: `cargo run --bin Code_3_05_1`
- Code_3_06_1: 入力: `N` 改行 `A1..AN`（sort）例: `echo "5\n3 1 4 1 5" | cargo run --bin Code_3_06_1`
- Code_3_06_2: 入力: `N` 改行 `A1..AN`（選択ソート）例: `echo "5\n3 1 4 1 5" | cargo run --bin Code_3_06_2`
- Code_3_06_3: 入力: `N`（階乗）例: `echo "5" | cargo run --bin Code_3_06_3`
- Code_3_06_5: 入力: `N` 改行 `A1..AN`（分割統治で総和）例: `echo "3\n10 20 30" | cargo run --bin Code_3_06_5`
- Code_3_07_1: 入力: `N` 改行 `H1..HN`（Frog DP）例: `echo "4\n10 30 40 20" | cargo run --bin Code_3_07_1`
- Code_3_07_2: 入力: `N`（DP）例: `echo "5" | cargo run --bin Code_3_07_2`
- Code_3_07_3: 入力: `N W` 改行 `w v`×N（0-1ナップサック）例: `echo "3 5\n2 3\n2 2\n4 4" | cargo run --bin Code_3_07_3`
- Code_3_08_1: 入力: `N X` 改行 `A1..AN`（二分探索）例: `echo "5 4\n1 3 5 7 9" | cargo run --bin Code_3_08_1`

章4
- Code_4_01_1: 入力: `ax ay bx by cx cy`（点と線分距離）例: `echo "0 0 1 0 0 1" | cargo run --bin Code_4_01_1`
- Code_4_02_1: 入力: `N Q` 改行 `A1..AN` 改行 `L R`×Q（区間和）例: `echo "5 2\n1 2 3 4 5\n1 3\n2 5" | cargo run --bin Code_4_02_1`
- Code_4_02_2: 入力: `N Q` 改行 `L R X`×Q（差分の符号列）例: `echo "5 2\n1 3 1\n2 5 -1" | cargo run --bin Code_4_02_2`
- Code_4_03_1: 入力なし（ニュートン法）例: `cargo run --bin Code_4_03_1`
- Code_4_04_1: 入力: `N`（エラトステネス）例: `echo "30" | cargo run --bin Code_4_04_1`
- Code_4_05_1: 入力: `N M` 改行 `A B`×M（隣接リスト出力）例: `echo "3 2\n1 2\n2 3" | cargo run --bin Code_4_05_1`
- Code_4_05_2: 入力: `N M` 改行 `A B`×M（DFS連結判定）例: `echo "3 2\n1 2\n2 3" | cargo run --bin Code_4_05_2`
- Code_4_05_2_stack: 入力: 同上（スタックDFS）例: `echo "3 2\n1 2\n2 3" | cargo run --bin Code_4_05_2_stack`
- Code_4_05_3: 入力: `N M` 改行 `A B`×M（BFS距離）例: `echo "4 3\n1 2\n2 3\n3 4" | cargo run --bin Code_4_05_3`
- Code_4_06_1: 入力: `N`（フィボナッチ→最後に1e9+7で出力）例: `echo "10" | cargo run --bin Code_4_06_1`
- Code_4_06_2: 入力: `N`（フィボナッチDP mod）例: `echo "10" | cargo run --bin Code_4_06_2`
- Code_4_06_3: 入力: `a b`（繰返し乗算 mod）例: `echo "3 5" | cargo run --bin Code_4_06_3`
- Code_4_06_4: 入力: `a b`（二分累乗 mod）例: `echo "3 5" | cargo run --bin Code_4_06_4`
- Code_4_06_5: 入力: `X Y`（(X+Y)!/(X!Y!) mod）例: `echo "2 3" | cargo run --bin Code_4_06_5`
- Code_4_06_6: 入力: `X Y`（前計算ありのnCr）例: `echo "2 3" | cargo run --bin Code_4_06_6`
- Code_4_07_1: 入力: `N`（行列累乗でFibonacci mod 1e9）例: `echo "10" | cargo run --bin Code_4_07_1`

章5
- Code_5_02_1: 入力: `N`（2^Nの下一桁）例: `echo "7" | cargo run --bin Code_5_02_1`
- Code_5_02_2: 入力: `N`（First/Second）例: `echo "8" | cargo run --bin Code_5_02_2`
- Code_5_03_1: 入力: `N`（偶奇判定）例: `echo "4" | cargo run --bin Code_5_03_1`
- Code_5_03_2: 入力: `N K` 改行 `A1..AN`（可否判定）例: `echo "3 7\n3 2 2" | cargo run --bin Code_5_03_2`
- Code_5_04_1: 入力: `N K`（三重ループの数え上げ）例: `echo "3 2" | cargo run --bin Code_5_04_1`
- Code_5_05_1: 入力: `a b c d`（積の最大）例: `echo "-2 3 -5 4" | cargo run --bin Code_5_05_1`
- Code_5_05_2: 入力: `N K` 改行 `X Y`×N（最小長方形面積）例: `echo "3 2\n0 0\n1 1\n2 2" | cargo run --bin Code_5_05_2`
- Code_5_06_1: 入力: `A B`（最大t）例: `echo "5 20" | cargo run --bin Code_5_06_1`
- Code_5_07_1: 入力: `N` 改行 `A1..AN`（重み付き和）例: `echo "5\n1 2 3 4 5" | cargo run --bin Code_5_07_1`
- Code_5_07_2: 入力: `N` 改行 `A1..AN`（nCr係数の総和 mod）例: `echo "3\n1 2 3" | cargo run --bin Code_5_07_2`
- Code_5_09_1: 入力: `N`（10000/5000/1000の枚数最小）例: `echo "26000" | cargo run --bin Code_5_09_1`
- Code_5_09_2: 入力: `N` 改行 `L R`×N（区間スケジューリング）例: `echo "3\n0 10\n10 20\n5 15" | cargo run --bin Code_5_09_2`
- Code_5_10_1: 入力: `a b c`（√a+√b<√c?）例: `echo "1 1 5" | cargo run --bin Code_5_10_1`
- Code_5_10_2: 入力: `a b c`（不等式判定）例: `echo "2 2 10" | cargo run --bin Code_5_10_2`
- Code_5_10_3: 入力: `N X Y`（a≤b≤c≤dの探索）例: `echo "5 10 24" | cargo run --bin Code_5_10_3`
- Code_5_10_4: 入力: `N S`（括弧列判定）例: `echo "6 (()())" | cargo run --bin Code_5_10_4`

備考
- 一部プログラムは出力が複数行になります。必要に応じて `> out.txt` でリダイレクトしてください。
- 入力は空白・改行区切りのトークンとして読み取ります（共通スキャナ: `src/lib.rs`）。
