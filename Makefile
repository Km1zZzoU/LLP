# Правило по умолчанию
.DEFAULT_GOAL := all

# Правило для выполнения команды с переданным именем файла
run:
	@echo "Assembling and running $(name).asm..."
	nasm -f elf64 -o $(name).o $(name).asm && ld $(name).o -o $(name) && ./$(name) $(arg1) $(arg2) && rm $(name).o && rm $(name)

strace_run:
	@echo "Assembling and running $(name).asm..."
	nasm -f elf64 -o $(name).o $(name).asm && ld $(name).o -o $(name) && strace ./$(name) $(args) $(arg2) && rm $(name).o && rm $(name)

debug_run:
	nasm -f elf64 -o $(name).o $(name).asm && ld $(name).o -o $(name) && ./edb-debugger/build/edb --run $(name) $(arg1) $(arg2)

