# RUN: llvm-mc -triple=ve --show-encoding < %s \
# RUN:     | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
# RUN: llvm-mc -triple=ve -filetype=obj < %s | llvm-objdump -d - \
# RUN:     | FileCheck %s --check-prefixes=CHECK-INST

# CHECK-INST: vmaxs.w.sx %v11, %s20, %v22
# CHECK-ENCODING: encoding: [0x00,0x16,0x00,0x0b,0x00,0x94,0x20,0x8a]
vmaxs.w.sx %v11, %s20, %v22

# CHECK-INST: vmaxs.w.sx %vix, %vix, %vix
# CHECK-ENCODING: encoding: [0x00,0xff,0xff,0xff,0x00,0x00,0x00,0x8a]
vmaxs.w.sx %vix, %vix, %vix

# CHECK-INST: pvmaxs.lo %vix, 22, %v22
# CHECK-ENCODING: encoding: [0x00,0x16,0x00,0xff,0x00,0x16,0x60,0x8a]
vmaxs.w.zx %vix, 22, %v22

# CHECK-INST: pvmaxs.lo %vix, 22, %v22
# CHECK-ENCODING: encoding: [0x00,0x16,0x00,0xff,0x00,0x16,0x60,0x8a]
vmaxs.w %vix, 22, %v22

# CHECK-INST: pvmaxs.lo %v11, 63, %v22, %vm11
# CHECK-ENCODING: encoding: [0x00,0x16,0x00,0x0b,0x00,0x3f,0x6b,0x8a]
pvmaxs.lo %v11, 63, %v22, %vm11

# CHECK-INST: vmaxs.w.sx %v11, 63, %v22, %vm11
# CHECK-ENCODING: encoding: [0x00,0x16,0x00,0x0b,0x00,0x3f,0x2b,0x8a]
pvmaxs.lo.sx %v11, 63, %v22, %vm11

# CHECK-INST: pvmaxs.lo %v11, 63, %v22, %vm11
# CHECK-ENCODING: encoding: [0x00,0x16,0x00,0x0b,0x00,0x3f,0x6b,0x8a]
pvmaxs.lo.zx %v11, 63, %v22, %vm11

# CHECK-INST: pvmaxs.up %v11, %vix, %v22, %vm11
# CHECK-ENCODING: encoding: [0x00,0x16,0xff,0x0b,0x00,0x00,0x8b,0x8a]
pvmaxs.up %v11, %vix, %v22, %vm11

# CHECK-INST: pvmaxs %v12, %v20, %v22, %vm12
# CHECK-ENCODING: encoding: [0x00,0x16,0x14,0x0c,0x00,0x00,0xcc,0x8a]
pvmaxs %v12, %v20, %v22, %vm12

# CHECK-INST: vmins.w.sx %v11, %s20, %v22
# CHECK-ENCODING: encoding: [0x00,0x16,0x00,0x0b,0x00,0x94,0x30,0x8a]
vmins.w.sx %v11, %s20, %v22

# CHECK-INST: vmins.w.sx %vix, %vix, %vix
# CHECK-ENCODING: encoding: [0x00,0xff,0xff,0xff,0x00,0x00,0x10,0x8a]
vmins.w.sx %vix, %vix, %vix

# CHECK-INST: pvmins.lo %vix, 22, %v22
# CHECK-ENCODING: encoding: [0x00,0x16,0x00,0xff,0x00,0x16,0x70,0x8a]
vmins.w.zx %vix, 22, %v22

# CHECK-INST: pvmins.lo %vix, 22, %v22
# CHECK-ENCODING: encoding: [0x00,0x16,0x00,0xff,0x00,0x16,0x70,0x8a]
vmins.w %vix, 22, %v22

# CHECK-INST: pvmins.lo %v11, 63, %v22, %vm11
# CHECK-ENCODING: encoding: [0x00,0x16,0x00,0x0b,0x00,0x3f,0x7b,0x8a]
pvmins.lo %v11, 63, %v22, %vm11

# CHECK-INST: vmins.w.sx %v11, 63, %v22, %vm11
# CHECK-ENCODING: encoding: [0x00,0x16,0x00,0x0b,0x00,0x3f,0x3b,0x8a]
pvmins.lo.sx %v11, 63, %v22, %vm11

# CHECK-INST: pvmins.lo %v11, 63, %v22, %vm11
# CHECK-ENCODING: encoding: [0x00,0x16,0x00,0x0b,0x00,0x3f,0x7b,0x8a]
pvmins.lo.zx %v11, 63, %v22, %vm11

# CHECK-INST: pvmins.up %v11, %vix, %v22, %vm11
# CHECK-ENCODING: encoding: [0x00,0x16,0xff,0x0b,0x00,0x00,0x9b,0x8a]
pvmins.up %v11, %vix, %v22, %vm11

# CHECK-INST: pvmins %v12, %v20, %v22, %vm12
# CHECK-ENCODING: encoding: [0x00,0x16,0x14,0x0c,0x00,0x00,0xdc,0x8a]
pvmins %v12, %v20, %v22, %vm12
