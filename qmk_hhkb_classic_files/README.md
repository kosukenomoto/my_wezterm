# HHKB Classic Firmware update

## 保管してるファイル
- file:dapboot.bin
  - https://github.com/Duncaen/dapboot/tree/hhkb
  - 上記ビルド済みdapboot (STM用dfuをhhkb用にカスタムしたもの）
  - ビルドしたければdapboot/src配下で以下コマンドを実行(armビルドのためのtoolchainは個別インストールが必要）
    ```
    make TARGET=HHKB
    ```

- file:hogehoge.tar.gz
  - original hhkb classic のfirmwareを保管

## how to write dapboot
- https://geekhack.org/index.php?topic=106213.0
  - ここの情報を元にHHKBの裏蓋を開けて　R6 R85 をショートさせながらUSBをPC接続することでSTM32のDFUが起動する。
  - 起動後はショートは解除してOK
  - 以下のコマンドでdapbootを書き込む。（hhkbclassicのオリジナルのファームウェアはこのドキュメントの最後尾を参照。
  - （まず最初にやっておいたほうがいいです）

```
dfu-util -a 0 -s 0x08000000:leave -D dapboot.bin
```

 - 書き込み直後はdfudapbootが起動しっぱなしになるが気にしない。
 - webUSB DFUでdapboot版qmkをwriteするとqmkが作動する。
 - そして左右シフト＋escでdapbootdfu起動するようになる

## qmk hhkb_classic dapboot版のビルド
以下のコマンドでdockerbuild
- original https://github.com/Duncaen/qmk_firmware/tree/hhkb_classic
- myconfig https://github.com/kosukenomoto/qmk_firmware_for_hhkbclassic

```bash
git clone myconfig https://github.com/kosukenomoto/qmk_firmware_for_hhkbclassic qmk_firmware_hhkbclassic
git submodule sync --recursive  
git submodule update --init --recursive  
./util/docker_build.sh hhkb/classic/dapboot:20250808
```

## WebUSB DFU
- https://devanlai.github.io/webdfu/dfu-util/
  - ここからビルドしたqmkを指定して書き込み
  - dapboodをlsusbでみてdapbootを認識していなければだめ。
  - lshift rshift esc を同時押しでdapbood-dfuを起動できる

## WebUSB DFUを使わずqmkを書き込む方法
sudo dfu-utilで起動したdapbood-dfuを見てみる
<img width="1389" height="337" alt="image" src="https://github.com/user-attachments/assets/849dcd54-583a-47af-923f-378073555b2b" />
以下でデバイスの指定をして書き込み
<img width="790" height="569" alt="image" src="https://github.com/user-attachments/assets/959ca1ae-b878-481b-8a33-65a0b1f9bcff" />
- /etc/UDEVにルール加えればsudoでなくてもいけるのかも？

## そのほかメモoriginal hhkb firmwareの取得方法
- hhkb-eeprom.bin
- hhkb-opt.bin

;;dfu-util -a 0 -s 0x08000000 -U hhkb-flash-bank12.bin
  - hhkb-flash-bank12.bin --bank1+2                   
                                                 
;;dfu-util -a 0 -s 0x08000000:0x10000 -U hhkb-flash-bank1.bin
  - hhkb-flash-bank1.bin --bank1 only                            
                                                           
*** dapboot bank1 write ***                               
;;dfu-util -a 0 -s 0x08000000:leave -D dapboot.bin       
  - hhkb_firm_dapboot/dapboot.bin                          
                                                      
