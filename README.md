Test program:

```
    addi x6, x0, 8
    addi x1, x0, 1
    or x6, x6, x1
    sw x6, 8(x0)
    lw x7, 8(x0)
    add x7, x7, x1
    jal x8, 8
    add x7, x7, x1
    sub x7, x7, x1
    beq x7, x7, -36
```
