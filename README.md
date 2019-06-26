# Assembly Playground :rocket:

The junkyard for some of my stinky assembly code.

## Usage - Compiling .COM files

``` bash 
nasm -f bin name.asm -o name.com
```

``` bash
dosbox name.com
```

## Resources

* [Netwide Assembler \(NASM\)](https://www.nasm.us/)
* [DOSBox, an x86 emulator with DOS](https://www.dosbox.com/)
* [NASM Tutorial](https://cs.lmu.edu/~ray/notes/nasmtutorial/)
* [x86 Registers](http://www.eecg.toronto.edu/~amza/www.mindsec.com/files/x86regs.html)
* [Simply Floating Point Unit \(FPU\)](http://www.website.masmforum.com/tutorials/fptute/#intro)
* [FPU instructions example \(NASM, for Linux\) by nikAizuddin](https://gist.github.com/nikAizuddin/0e307cac142792dcdeba)

# Advanced stuff

## Usage - Compiling .OUT files without C library

``` bash
nasm -f elf64 name.asm && ld name.o && ./a.out
```

## Usage - Compiling .OUT files with C library

``` bash
nasm -f elf64 name.asm && gcc name.o && ./a.out
```

## Usage - Compiling .OUT files with a C program

``` bash
nasm -f elf64 name.asm && gcc program.c name.o && ./a.out
```


