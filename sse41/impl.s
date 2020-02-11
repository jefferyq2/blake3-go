// Code generated by command: go run compress.go. DO NOT EDIT.

#include "textflag.h"

DATA iv<>+0(SB)/4, $0x6a09e667
DATA iv<>+4(SB)/4, $0xbb67ae85
DATA iv<>+8(SB)/4, $0x3c6ef372
DATA iv<>+12(SB)/4, $0xa54ff53a
DATA iv<>+16(SB)/4, $0x510e527f
DATA iv<>+20(SB)/4, $0x9b05688c
DATA iv<>+24(SB)/4, $0x1f83d9ab
DATA iv<>+28(SB)/4, $0x5be0cd19
GLOBL iv<>(SB), RODATA|NOPTR, $32

DATA rot16_shuf<>+0(SB)/1, $0x02
DATA rot16_shuf<>+1(SB)/1, $0x03
DATA rot16_shuf<>+2(SB)/1, $0x00
DATA rot16_shuf<>+3(SB)/1, $0x01
DATA rot16_shuf<>+4(SB)/1, $0x06
DATA rot16_shuf<>+5(SB)/1, $0x07
DATA rot16_shuf<>+6(SB)/1, $0x04
DATA rot16_shuf<>+7(SB)/1, $0x05
DATA rot16_shuf<>+8(SB)/1, $0x0a
DATA rot16_shuf<>+9(SB)/1, $0x0b
DATA rot16_shuf<>+10(SB)/1, $0x08
DATA rot16_shuf<>+11(SB)/1, $0x09
DATA rot16_shuf<>+12(SB)/1, $0x0e
DATA rot16_shuf<>+13(SB)/1, $0x0f
DATA rot16_shuf<>+14(SB)/1, $0x0c
DATA rot16_shuf<>+15(SB)/1, $0x0d
DATA rot16_shuf<>+16(SB)/1, $0x12
DATA rot16_shuf<>+17(SB)/1, $0x13
DATA rot16_shuf<>+18(SB)/1, $0x10
DATA rot16_shuf<>+19(SB)/1, $0x11
DATA rot16_shuf<>+20(SB)/1, $0x16
DATA rot16_shuf<>+21(SB)/1, $0x17
DATA rot16_shuf<>+22(SB)/1, $0x14
DATA rot16_shuf<>+23(SB)/1, $0x15
DATA rot16_shuf<>+24(SB)/1, $0x1a
DATA rot16_shuf<>+25(SB)/1, $0x1b
DATA rot16_shuf<>+26(SB)/1, $0x18
DATA rot16_shuf<>+27(SB)/1, $0x19
DATA rot16_shuf<>+28(SB)/1, $0x1e
DATA rot16_shuf<>+29(SB)/1, $0x1f
DATA rot16_shuf<>+30(SB)/1, $0x1c
DATA rot16_shuf<>+31(SB)/1, $0x1d
GLOBL rot16_shuf<>(SB), RODATA|NOPTR, $32

DATA rot8_shuf<>+0(SB)/1, $0x01
DATA rot8_shuf<>+1(SB)/1, $0x02
DATA rot8_shuf<>+2(SB)/1, $0x03
DATA rot8_shuf<>+3(SB)/1, $0x00
DATA rot8_shuf<>+4(SB)/1, $0x05
DATA rot8_shuf<>+5(SB)/1, $0x06
DATA rot8_shuf<>+6(SB)/1, $0x07
DATA rot8_shuf<>+7(SB)/1, $0x04
DATA rot8_shuf<>+8(SB)/1, $0x09
DATA rot8_shuf<>+9(SB)/1, $0x0a
DATA rot8_shuf<>+10(SB)/1, $0x0b
DATA rot8_shuf<>+11(SB)/1, $0x08
DATA rot8_shuf<>+12(SB)/1, $0x0d
DATA rot8_shuf<>+13(SB)/1, $0x0e
DATA rot8_shuf<>+14(SB)/1, $0x0f
DATA rot8_shuf<>+15(SB)/1, $0x0c
DATA rot8_shuf<>+16(SB)/1, $0x11
DATA rot8_shuf<>+17(SB)/1, $0x12
DATA rot8_shuf<>+18(SB)/1, $0x13
DATA rot8_shuf<>+19(SB)/1, $0x10
DATA rot8_shuf<>+20(SB)/1, $0x15
DATA rot8_shuf<>+21(SB)/1, $0x16
DATA rot8_shuf<>+22(SB)/1, $0x17
DATA rot8_shuf<>+23(SB)/1, $0x14
DATA rot8_shuf<>+24(SB)/1, $0x19
DATA rot8_shuf<>+25(SB)/1, $0x1a
DATA rot8_shuf<>+26(SB)/1, $0x1b
DATA rot8_shuf<>+27(SB)/1, $0x18
DATA rot8_shuf<>+28(SB)/1, $0x1d
DATA rot8_shuf<>+29(SB)/1, $0x1e
DATA rot8_shuf<>+30(SB)/1, $0x1f
DATA rot8_shuf<>+31(SB)/1, $0x1c
GLOBL rot8_shuf<>(SB), RODATA|NOPTR, $32

// func Compress(chain *[8]uint32, block *[16]uint32, counter uint64, blen uint32, flags uint32, out *[16]uint32)
// Requires: AVX, SSE, SSE2, SSE4.1, SSSE3
TEXT ·Compress(SB), NOSPLIT, $0-40
	MOVQ   chain+0(FP), AX
	MOVQ   block+8(FP), CX
	MOVQ   counter+16(FP), DX
	MOVL   blen+24(FP), BX
	MOVL   flags+28(FP), BP
	MOVQ   out+32(FP), SI
	MOVUPS (AX), X0
	MOVUPS 16(AX), X1
	MOVUPS iv<>+0(SB), X2
	PINSRD $0x00, DX, X3
	SHRQ   $0x20, DX
	PINSRD $0x01, DX, X3
	PINSRD $0x02, BX, X3
	PINSRD $0x03, BP, X3
	MOVUPS (CX), X4
	MOVUPS 16(CX), X5
	MOVUPS 32(CX), X6
	MOVUPS 48(CX), X7
	MOVUPS rot16_shuf<>+0(SB), X8
	MOVUPS rot8_shuf<>+0(SB), X9

	// round 1
	MOVAPS X4, X10
	SHUFPS $0x88, X5, X10
	PADDD  X10, X0
	PADDD  X1, X0
	PXOR   X0, X3
	PSHUFB X8, X3
	PADDD  X3, X2
	PXOR   X2, X1
	MOVAPS X1, X11
	PSRLL  $0x0c, X1
	PSLLL  $0x14, X11
	POR    X11, X1
	MOVAPS X4, X4
	SHUFPS $0xdd, X5, X4
	PADDD  X4, X0
	PADDD  X1, X0
	PXOR   X0, X3
	PSHUFB X9, X3
	PADDD  X3, X2
	PXOR   X2, X1
	MOVAPS X1, X5
	PSRLL  $0x07, X1
	PSLLL  $0x19, X5
	POR    X5, X1
	PSHUFD $0x93, X0, X0
	PSHUFD $0x4e, X3, X3
	PSHUFD $0x39, X2, X2
	MOVAPS X6, X5
	SHUFPS $0x88, X7, X5
	SHUFPS $0x93, X5, X5
	PADDD  X5, X0
	PADDD  X1, X0
	PXOR   X0, X3
	PSHUFB X8, X3
	PADDD  X3, X2
	PXOR   X2, X1
	MOVAPS X1, X11
	PSRLL  $0x0c, X1
	PSLLL  $0x14, X11
	POR    X11, X1
	MOVAPS X6, X6
	SHUFPS $0xdd, X7, X6
	SHUFPS $0x93, X6, X6
	PADDD  X6, X0
	PADDD  X1, X0
	PXOR   X0, X3
	PSHUFB X9, X3
	PADDD  X3, X2
	PXOR   X2, X1
	MOVAPS X1, X7
	PSRLL  $0x07, X1
	PSLLL  $0x19, X7
	POR    X7, X1
	PSHUFD $0x39, X0, X0
	PSHUFD $0x4e, X3, X3
	PSHUFD $0x93, X2, X2

	// round 2
	MOVAPS     X10, X7
	SHUFPS     $0xd6, X4, X7
	SHUFPS     $0x39, X7, X7
	PADDD      X7, X0
	PADDD      X1, X0
	PXOR       X0, X3
	PSHUFB     X8, X3
	PADDD      X3, X2
	PXOR       X2, X1
	MOVAPS     X1, X11
	PSRLL      $0x0c, X1
	PSLLL      $0x14, X11
	POR        X11, X1
	MOVAPS     X5, X11
	SHUFPS     $0xfa, X6, X11
	PSHUFD     $0x0f, X10, X10
	PBLENDW    $0x33, X10, X11
	PADDD      X11, X0
	PADDD      X1, X0
	PXOR       X0, X3
	PSHUFB     X9, X3
	PADDD      X3, X2
	PXOR       X2, X1
	MOVAPS     X1, X10
	PSRLL      $0x07, X1
	PSLLL      $0x19, X10
	POR        X10, X1
	PSHUFD     $0x93, X0, X0
	PSHUFD     $0x4e, X3, X3
	PSHUFD     $0x39, X2, X2
	MOVAPS     X6, X12
	VPUNPCKLDQ X4, X12, X12
	PBLENDW    $0xc0, X5, X12
	SHUFPS     $0xb4, X12, X12
	PADDD      X12, X0
	PADDD      X1, X0
	PXOR       X0, X3
	PSHUFB     X8, X3
	PADDD      X3, X2
	PXOR       X2, X1
	MOVAPS     X1, X10
	PSRLL      $0x0c, X1
	PSLLL      $0x14, X10
	POR        X10, X1
	MOVAPS     X4, X10
	VPUNPCKHDQ X6, X10, X10
	MOVAPS     X5, X4
	VPUNPCKLDQ X10, X4, X4
	SHUFPS     $0x1e, X4, X4
	PADDD      X4, X0
	PADDD      X1, X0
	PXOR       X0, X3
	PSHUFB     X9, X3
	PADDD      X3, X2
	PXOR       X2, X1
	MOVAPS     X1, X5
	PSRLL      $0x07, X1
	PSLLL      $0x19, X5
	POR        X5, X1
	PSHUFD     $0x39, X0, X0
	PSHUFD     $0x4e, X3, X3
	PSHUFD     $0x93, X2, X2

	// round 3
	MOVAPS     X7, X5
	SHUFPS     $0xd6, X11, X5
	SHUFPS     $0x39, X5, X5
	PADDD      X5, X0
	PADDD      X1, X0
	PXOR       X0, X3
	PSHUFB     X8, X3
	PADDD      X3, X2
	PXOR       X2, X1
	MOVAPS     X1, X6
	PSRLL      $0x0c, X1
	PSLLL      $0x14, X6
	POR        X6, X1
	MOVAPS     X12, X6
	SHUFPS     $0xfa, X4, X6
	PSHUFD     $0x0f, X7, X7
	PBLENDW    $0x33, X7, X6
	PADDD      X6, X0
	PADDD      X1, X0
	PXOR       X0, X3
	PSHUFB     X9, X3
	PADDD      X3, X2
	PXOR       X2, X1
	MOVAPS     X1, X7
	PSRLL      $0x07, X1
	PSLLL      $0x19, X7
	POR        X7, X1
	PSHUFD     $0x93, X0, X0
	PSHUFD     $0x4e, X3, X3
	PSHUFD     $0x39, X2, X2
	MOVAPS     X4, X10
	VPUNPCKLDQ X11, X10, X10
	PBLENDW    $0xc0, X12, X10
	SHUFPS     $0xb4, X10, X10
	PADDD      X10, X0
	PADDD      X1, X0
	PXOR       X0, X3
	PSHUFB     X8, X3
	PADDD      X3, X2
	PXOR       X2, X1
	MOVAPS     X1, X7
	PSRLL      $0x0c, X1
	PSLLL      $0x14, X7
	POR        X7, X1
	MOVAPS     X11, X7
	VPUNPCKHDQ X4, X7, X7
	MOVAPS     X12, X4
	VPUNPCKLDQ X7, X4, X4
	SHUFPS     $0x1e, X4, X4
	PADDD      X4, X0
	PADDD      X1, X0
	PXOR       X0, X3
	PSHUFB     X9, X3
	PADDD      X3, X2
	PXOR       X2, X1
	MOVAPS     X1, X7
	PSRLL      $0x07, X1
	PSLLL      $0x19, X7
	POR        X7, X1
	PSHUFD     $0x39, X0, X0
	PSHUFD     $0x4e, X3, X3
	PSHUFD     $0x93, X2, X2

	// round 4
	MOVAPS     X5, X7
	SHUFPS     $0xd6, X6, X7
	SHUFPS     $0x39, X7, X7
	PADDD      X7, X0
	PADDD      X1, X0
	PXOR       X0, X3
	PSHUFB     X8, X3
	PADDD      X3, X2
	PXOR       X2, X1
	MOVAPS     X1, X11
	PSRLL      $0x0c, X1
	PSLLL      $0x14, X11
	POR        X11, X1
	MOVAPS     X10, X11
	SHUFPS     $0xfa, X4, X11
	PSHUFD     $0x0f, X5, X5
	PBLENDW    $0x33, X5, X11
	PADDD      X11, X0
	PADDD      X1, X0
	PXOR       X0, X3
	PSHUFB     X9, X3
	PADDD      X3, X2
	PXOR       X2, X1
	MOVAPS     X1, X5
	PSRLL      $0x07, X1
	PSLLL      $0x19, X5
	POR        X5, X1
	PSHUFD     $0x93, X0, X0
	PSHUFD     $0x4e, X3, X3
	PSHUFD     $0x39, X2, X2
	MOVAPS     X4, X12
	VPUNPCKLDQ X6, X12, X12
	PBLENDW    $0xc0, X10, X12
	SHUFPS     $0xb4, X12, X12
	PADDD      X12, X0
	PADDD      X1, X0
	PXOR       X0, X3
	PSHUFB     X8, X3
	PADDD      X3, X2
	PXOR       X2, X1
	MOVAPS     X1, X5
	PSRLL      $0x0c, X1
	PSLLL      $0x14, X5
	POR        X5, X1
	MOVAPS     X6, X5
	VPUNPCKHDQ X4, X5, X5
	MOVAPS     X10, X4
	VPUNPCKLDQ X5, X4, X4
	SHUFPS     $0x1e, X4, X4
	PADDD      X4, X0
	PADDD      X1, X0
	PXOR       X0, X3
	PSHUFB     X9, X3
	PADDD      X3, X2
	PXOR       X2, X1
	MOVAPS     X1, X5
	PSRLL      $0x07, X1
	PSLLL      $0x19, X5
	POR        X5, X1
	PSHUFD     $0x39, X0, X0
	PSHUFD     $0x4e, X3, X3
	PSHUFD     $0x93, X2, X2

	// round 5
	MOVAPS     X7, X5
	SHUFPS     $0xd6, X11, X5
	SHUFPS     $0x39, X5, X5
	PADDD      X5, X0
	PADDD      X1, X0
	PXOR       X0, X3
	PSHUFB     X8, X3
	PADDD      X3, X2
	PXOR       X2, X1
	MOVAPS     X1, X6
	PSRLL      $0x0c, X1
	PSLLL      $0x14, X6
	POR        X6, X1
	MOVAPS     X12, X6
	SHUFPS     $0xfa, X4, X6
	PSHUFD     $0x0f, X7, X7
	PBLENDW    $0x33, X7, X6
	PADDD      X6, X0
	PADDD      X1, X0
	PXOR       X0, X3
	PSHUFB     X9, X3
	PADDD      X3, X2
	PXOR       X2, X1
	MOVAPS     X1, X7
	PSRLL      $0x07, X1
	PSLLL      $0x19, X7
	POR        X7, X1
	PSHUFD     $0x93, X0, X0
	PSHUFD     $0x4e, X3, X3
	PSHUFD     $0x39, X2, X2
	MOVAPS     X4, X10
	VPUNPCKLDQ X11, X10, X10
	PBLENDW    $0xc0, X12, X10
	SHUFPS     $0xb4, X10, X10
	PADDD      X10, X0
	PADDD      X1, X0
	PXOR       X0, X3
	PSHUFB     X8, X3
	PADDD      X3, X2
	PXOR       X2, X1
	MOVAPS     X1, X7
	PSRLL      $0x0c, X1
	PSLLL      $0x14, X7
	POR        X7, X1
	MOVAPS     X11, X7
	VPUNPCKHDQ X4, X7, X7
	MOVAPS     X12, X4
	VPUNPCKLDQ X7, X4, X4
	SHUFPS     $0x1e, X4, X4
	PADDD      X4, X0
	PADDD      X1, X0
	PXOR       X0, X3
	PSHUFB     X9, X3
	PADDD      X3, X2
	PXOR       X2, X1
	MOVAPS     X1, X7
	PSRLL      $0x07, X1
	PSLLL      $0x19, X7
	POR        X7, X1
	PSHUFD     $0x39, X0, X0
	PSHUFD     $0x4e, X3, X3
	PSHUFD     $0x93, X2, X2

	// round 6
	MOVAPS     X5, X7
	SHUFPS     $0xd6, X6, X7
	SHUFPS     $0x39, X7, X7
	PADDD      X7, X0
	PADDD      X1, X0
	PXOR       X0, X3
	PSHUFB     X8, X3
	PADDD      X3, X2
	PXOR       X2, X1
	MOVAPS     X1, X11
	PSRLL      $0x0c, X1
	PSLLL      $0x14, X11
	POR        X11, X1
	MOVAPS     X10, X11
	SHUFPS     $0xfa, X4, X11
	PSHUFD     $0x0f, X5, X5
	PBLENDW    $0x33, X5, X11
	PADDD      X11, X0
	PADDD      X1, X0
	PXOR       X0, X3
	PSHUFB     X9, X3
	PADDD      X3, X2
	PXOR       X2, X1
	MOVAPS     X1, X5
	PSRLL      $0x07, X1
	PSLLL      $0x19, X5
	POR        X5, X1
	PSHUFD     $0x93, X0, X0
	PSHUFD     $0x4e, X3, X3
	PSHUFD     $0x39, X2, X2
	MOVAPS     X4, X12
	VPUNPCKLDQ X6, X12, X12
	PBLENDW    $0xc0, X10, X12
	SHUFPS     $0xb4, X12, X12
	PADDD      X12, X0
	PADDD      X1, X0
	PXOR       X0, X3
	PSHUFB     X8, X3
	PADDD      X3, X2
	PXOR       X2, X1
	MOVAPS     X1, X5
	PSRLL      $0x0c, X1
	PSLLL      $0x14, X5
	POR        X5, X1
	MOVAPS     X6, X5
	VPUNPCKHDQ X4, X5, X5
	MOVAPS     X10, X4
	VPUNPCKLDQ X5, X4, X4
	SHUFPS     $0x1e, X4, X4
	PADDD      X4, X0
	PADDD      X1, X0
	PXOR       X0, X3
	PSHUFB     X9, X3
	PADDD      X3, X2
	PXOR       X2, X1
	MOVAPS     X1, X5
	PSRLL      $0x07, X1
	PSLLL      $0x19, X5
	POR        X5, X1
	PSHUFD     $0x39, X0, X0
	PSHUFD     $0x4e, X3, X3
	PSHUFD     $0x93, X2, X2

	// round 7
	MOVAPS     X7, X5
	SHUFPS     $0xd6, X11, X5
	SHUFPS     $0x39, X5, X5
	PADDD      X5, X0
	PADDD      X1, X0
	PXOR       X0, X3
	PSHUFB     X8, X3
	PADDD      X3, X2
	PXOR       X2, X1
	MOVAPS     X1, X5
	PSRLL      $0x0c, X1
	PSLLL      $0x14, X5
	POR        X5, X1
	MOVAPS     X12, X5
	SHUFPS     $0xfa, X4, X5
	PSHUFD     $0x0f, X7, X6
	PBLENDW    $0x33, X6, X5
	PADDD      X5, X0
	PADDD      X1, X0
	PXOR       X0, X3
	PSHUFB     X9, X3
	PADDD      X3, X2
	PXOR       X2, X1
	MOVAPS     X1, X5
	PSRLL      $0x07, X1
	PSLLL      $0x19, X5
	POR        X5, X1
	PSHUFD     $0x93, X0, X0
	PSHUFD     $0x4e, X3, X3
	PSHUFD     $0x39, X2, X2
	MOVAPS     X4, X5
	VPUNPCKLDQ X11, X5, X5
	PBLENDW    $0xc0, X12, X5
	SHUFPS     $0xb4, X5, X5
	PADDD      X5, X0
	PADDD      X1, X0
	PXOR       X0, X3
	PSHUFB     X8, X3
	PADDD      X3, X2
	PXOR       X2, X1
	MOVAPS     X1, X5
	PSRLL      $0x0c, X1
	PSLLL      $0x14, X5
	POR        X5, X1
	MOVAPS     X11, X6
	VPUNPCKHDQ X4, X6, X6
	MOVAPS     X12, X4
	VPUNPCKLDQ X6, X4, X4
	SHUFPS     $0x1e, X4, X4
	PADDD      X4, X0
	PADDD      X1, X0
	PXOR       X0, X3
	PSHUFB     X9, X3
	PADDD      X3, X2
	PXOR       X2, X1
	MOVAPS     X1, X4
	PSRLL      $0x07, X1
	PSLLL      $0x19, X4
	POR        X4, X1
	PSHUFD     $0x39, X0, X0
	PSHUFD     $0x4e, X3, X3
	PSHUFD     $0x93, X2, X2

	// finalize
	PXOR   X2, X0
	PXOR   X3, X1
	MOVUPS (AX), X4
	PXOR   X4, X2
	MOVUPS 16(AX), X4
	PXOR   X4, X3
	MOVUPS X0, (SI)
	MOVUPS X1, 16(SI)
	MOVUPS X2, 32(SI)
	MOVUPS X3, 48(SI)
	RET
