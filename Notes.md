# Notes

## Determining CPU capabilities and features

Different revisions of x86 processors have additional features such as
MMX or FPU. You can find this out somewhat easily depending on the OS
you are using.

You can also use the CPUID opcode: https://en.wikipedia.org/wiki/CPUID
TODO: an example of this

If all else fails, you can pop the case off of your machine, look for
any identifying marks on your chip, and Google it. This approach may
be ugly and require scraping off and re-applying thermal compound.

### Linux

```
cat /proc/cpuinfo |grep flags |head -n1
```

You should see output similar to this:

```
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx rdtscp lm
constant_tsc rep_good nopl xtopology nonstop_tsc pni pclmulqdq ssse3
cx16 sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx rdrand hypervisor
lahf_lm abm 3dnowprefetch rdseed clflushopt
```

### Windows

The easiest way I've found to do this so far is to use the "coreinfo"
utility that is included with Sysinternals:

```
Coreinfo v3.31 - Dump information on system CPU and memory topology
Copyright (C) 2008-2014 Mark Russinovich
Sysinternals - www.sysinternals.com

Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz
Intel64 Family 6 Model 94 Stepping 3, GenuineIntel
Microcode signature: 0000009E
HTT             *       Hyperthreading enabled
HYPERVISOR      -       Hypervisor is present
VMX             *       Supports Intel hardware-assisted virtualization
SVM             -       Supports AMD hardware-assisted virtualization
X64             *       Supports 64-bit mode

SMX             -       Supports Intel trusted execution
SKINIT          -       Supports AMD SKINIT

NX              *       Supports no-execute page protection
SMEP            *       Supports Supervisor Mode Execution Prevention
SMAP            *       Supports Supervisor Mode Access Prevention
PAGE1GB         *       Supports 1 GB large pages
PAE             *       Supports > 32-bit physical addresses
PAT             *       Supports Page Attribute Table
PSE             *       Supports 4 MB pages
PSE36           *       Supports > 32-bit address 4 MB pages
PGE             *       Supports global bit in page tables
SS              *       Supports bus snooping for cache operations
VME             *       Supports Virtual-8086 mode
RDWRFSGSBASE    *       Supports direct GS/FS base access

FPU             *       Implements i387 floating point instructions
MMX             *       Supports MMX instruction set
MMXEXT          -       Implements AMD MMX extensions
3DNOW           -       Supports 3DNow! instructions
3DNOWEXT        -       Supports 3DNow! extension instructions
SSE             *       Supports Streaming SIMD Extensions
SSE2            *       Supports Streaming SIMD Extensions 2
SSE3            *       Supports Streaming SIMD Extensions 3
SSSE3           *       Supports Supplemental SIMD Extensions 3
SSE4a           -       Supports Streaming SIMDR Extensions 4a
SSE4.1          *       Supports Streaming SIMD Extensions 4.1
SSE4.2          *       Supports Streaming SIMD Extensions 4.2

AES             *       Supports AES extensions
AVX             *       Supports AVX intruction extensions
FMA             *       Supports FMA extensions using YMM state
MSR             *       Implements RDMSR/WRMSR instructions
MTRR            *       Supports Memory Type Range Registers
XSAVE           *       Supports XSAVE/XRSTOR instructions
OSXSAVE         *       Supports XSETBV/XGETBV instructions
RDRAND          *       Supports RDRAND instruction
RDSEED          *       Supports RDSEED instruction

CMOV            *       Supports CMOVcc instruction
CLFSH           *       Supports CLFLUSH instruction
CX8             *       Supports compare and exchange 8-byte instructions
CX16            *       Supports CMPXCHG16B instruction
BMI1            *       Supports bit manipulation extensions 1
BMI2            *       Supports bit manipulation extensions 2
ADX             *       Supports ADCX/ADOX instructions
DCA             -       Supports prefetch from memory-mapped device
F16C            *       Supports half-precision instruction
FXSR            *       Supports FXSAVE/FXSTOR instructions
FFXSR           -       Supports optimized FXSAVE/FSRSTOR instruction
MONITOR         *       Supports MONITOR and MWAIT instructions
MOVBE           *       Supports MOVBE instruction
ERMSB           *       Supports Enhanced REP MOVSB/STOSB
PCLMULDQ        *       Supports PCLMULDQ instruction
POPCNT          *       Supports POPCNT instruction
LZCNT           *       Supports LZCNT instruction
SEP             *       Supports fast system call instructions
LAHF-SAHF       *       Supports LAHF/SAHF instructions in 64-bit mode
HLE             *       Supports Hardware Lock Elision instructions
RTM             *       Supports Restricted Transactional Memory instructions

DE              *       Supports I/O breakpoints including CR4.DE
DTES64          *       Can write history of 64-bit branch addresses
DS              *       Implements memory-resident debug buffer
DS-CPL          *       Supports Debug Store feature with CPL
PCID            *       Supports PCIDs and settable CR4.PCIDE
INVPCID         *       Supports INVPCID instruction
PDCM            *       Supports Performance Capabilities MSR
RDTSCP          *       Supports RDTSCP instruction
TSC             *       Supports RDTSC instruction
TSC-DEADLINE    *       Local APIC supports one-shot deadline timer
TSC-INVARIANT   *       TSC runs at constant rate
xTPR            *       Supports disabling task priority messages

EIST            *       Supports Enhanced Intel Speedstep
ACPI            *       Implements MSR for power management
TM              *       Implements thermal monitor circuitry
TM2             *       Implements Thermal Monitor 2 control
APIC            *       Implements software-accessible local APIC
x2APIC          *       Supports x2APIC

CNXT-ID         -       L1 data cache mode adaptive or BIOS

MCE             *       Supports Machine Check, INT18 and CR4.MCE
MCA             *       Implements Machine Check Architecture
PBE             *       Supports use of FERR#/PBE# pin

PSN             -       Implements 96-bit processor serial number

PREFETCHW       *       Supports PREFETCHW instruction

Maximum implemented CPUID leaves: 00000016 (Basic), 80000008 (Extended).

Logical to Physical Processor Map:
**------  Physical Processor 0 (Hyperthreaded)
--**----  Physical Processor 1 (Hyperthreaded)
----**--  Physical Processor 2 (Hyperthreaded)
------**  Physical Processor 3 (Hyperthreaded)

Logical Processor to Socket Map:
********  Socket 0

Logical Processor to NUMA Node Map:
********  NUMA Node 0

No NUMA nodes.

Logical Processor to Cache Map:
**------  Data Cache          0, Level 1,   32 KB, Assoc   8, LineSize  64
**------  Instruction Cache   0, Level 1,   32 KB, Assoc   8, LineSize  64
**------  Unified Cache       0, Level 2,  256 KB, Assoc   4, LineSize  64
********  Unified Cache       1, Level 3,    6 MB, Assoc  12, LineSize  64
--**----  Data Cache          1, Level 1,   32 KB, Assoc   8, LineSize  64
--**----  Instruction Cache   1, Level 1,   32 KB, Assoc   8, LineSize  64
--**----  Unified Cache       2, Level 2,  256 KB, Assoc   4, LineSize  64
----**--  Data Cache          2, Level 1,   32 KB, Assoc   8, LineSize  64
----**--  Instruction Cache   2, Level 1,   32 KB, Assoc   8, LineSize  64
----**--  Unified Cache       3, Level 2,  256 KB, Assoc   4, LineSize  64
------**  Data Cache          3, Level 1,   32 KB, Assoc   8, LineSize  64
------**  Instruction Cache   3, Level 1,   32 KB, Assoc   8, LineSize  64
------**  Unified Cache       4, Level 2,  256 KB, Assoc   4, LineSize  64

Logical Processor to Group Map:
********  Group 0
```

If installing sysinternals is not an option, you can right click on
"My Computer", select Properties, and do a Google search of your CPU's
model number. For best results, I use the inurl modifier in my search
to narrow the search results down to the CPU's manufacturer (ex:
inurl:intel.com i7-6700hq).

### FreeBSD

```
grep Features /var/run/dmesg.boot
```

This will output something like so:

```
  Features=0x178bfbff<FPU,VME,DE,PSE,TSC,MSR,PAE,MCE,CX8,APIC,SEP,MTRR,PGE,MCA,CMOV,PAT,PSE36,CLFLUSH,MMX,FXSR,SSE,SSE2,HTT>
  Features2=0x802009<SSE3,MON,CX16,POPCNT>
  AMD Features=0xee500800<SYSCALL,NX,MMX+,FFXSR,Page1GB,RDTSCP,LM,3DNow!+,3DNow!>
  AMD Features2=0x837ff<LAHF,CMP,SVM,ExtAPIC,CR8,ABM,SSE4A,MAS,Prefetch,OSVW,IBS,SKINIT,WDT,NodeId>
```

### OSX

TODO: this