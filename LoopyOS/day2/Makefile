LoopyOS.bin : LoopyOS.nas Makefile
	..\z_tools\nask.exe LoopyOS.nas LoopyOS.bin LoopyOS.lst

LoopyOS.img : LoopyOS.bin Makefile
	..\z_tools\edimg.exe imgin:..\z_tools\fdimg0at.tek \
		wbinimg src:LoopyOS.bin len:512 from:0 to:0 imgout:LoopyOS.img

# make -r LoopyOS.bin으로 호출 가능
# make -r LoopyOS.img으로 한번에 모두 호출 가능

img :
	..\z_tools\make.exe -r LoopyOS.img
asm :
	..\z_tools\make.exe -r LoopyOS.bin
run : 
	..\z_tools\make.exe img
	copy LoopyOS.img ..\z_tools\qemu\fdimage0.bin
	..\z_tools\make.exe -C ..\z_tools\qemu
install :
	..\z_tools\make.exe img
	..\z_tools\imgtol.com w a: LoopyOS.img