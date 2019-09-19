all : compiler.l compiler.y
	clear
	flex -id compiler.l
	bison compiler.y
	gcc compiler.tab.c -o main -lfl -lm
	./main