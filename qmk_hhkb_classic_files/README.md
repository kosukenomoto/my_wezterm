# HHKB Classic Firmware update

- https://github.com/Duncaen/qmk_firmware/tree/hhkb_classic
- https://github.com/Duncaen/dapboot/tree/hhkb
```bash
git clone -b hhkb_classic https://github.com/Duncaen/qmk_firmware.git qmk_firmware_hhkbclassic
git submodule sync --recursive  
git submodule update --init --recursive  
./util/docker_build.sh hhkb/classic/dapboot:duncaen 
or 
qmk build -kb hhkb/classic/dapboot -km duncaen
```

## 保管してるファイル
file:dapboot.bin
ビルド済みdapboot (STM用dfuをhhkb用にカスタムしたもの）
以下にも格納しているが、こっちを利用するほうがいい。（自分でビルドした）

file:./firmware
original hhkb classic のfirmwareを保管

## how to write dapboot
dfu-util -a 0 -s 0x08000000:leave -D dapboot.bin

## qmk hhkb_classic dapboot版のビルド
以下のコマンドでdockerbuild
./util/docker_build.sh hhkb/classic/dapboot:duncaen

## WebUSB DFU
https://devanlai.github.io/webdfu/dfu-util/
ここからビルドしたqmkを指定して書き込み
dapboodをlsusbでみてdapbootを認識していなければだめ。
lshift rshift esc を同時押しでdapbood-dfuを起動できる


## original hhkb firmwareの取得方法
hhkb-eeprom.bin
hhkb-opt.bin

;;dfu-util -a 0 -s 0x08000000 -U hhkb-flash-bank12.bin
hhkb-flash-bank12.bin --bank1+2                   
                                                 
;;dfu-util -a 0 -s 0x08000000:0x10000 -U hhkb-flash-bank1.bin
hhkb-flash-bank1.bin --bank1 only                            
                                                           
*** dapboot bank1 write ***                               
;;dfu-util -a 0 -s 0x08000000:leave -D dapboot.bin       
hhkb_firm_dapboot/dapboot.bin                          
                                                      
























