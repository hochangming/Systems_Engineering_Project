	.cpu cortex-m7
	.eabi_attribute 27, 1
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 2
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"deca_params_init.c"
	.text
	.global	txpwr_compensation
	.global	lde_replicaCoeff
	.global	digital_bb_config
	.global	dtune1
	.global	sftsh
	.global	dwnsSFDlen
	.global	agc_config
	.global	rx_config
	.global	fs_pll_tune
	.global	fs_pll_cfg
	.global	tx_config
	.global	chan_idx
	.section	.rodata.agc_config,"a"
	.align	2
	.type	agc_config, %object
	.size	agc_config, 8
agc_config:
	.word	620931335
	.short	-30608
	.short	-30565
	.section	.rodata.chan_idx,"a"
	.align	2
	.type	chan_idx, %object
	.size	chan_idx, 8
chan_idx:
	.byte	0
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	0
	.byte	5
	.section	.rodata.digital_bb_config,"a"
	.align	2
	.type	digital_bb_config, %object
	.size	digital_bb_config, 32
digital_bb_config:
	.word	823787565
	.word	857342034
	.word	890896538
	.word	924451101
	.word	825950315
	.word	859504830
	.word	893059422
	.word	926614166
	.section	.rodata.dtune1,"a"
	.align	2
	.type	dtune1, %object
	.size	dtune1, 4
dtune1:
	.short	135
	.short	141
	.section	.rodata.dwnsSFDlen,"a"
	.align	2
	.type	dwnsSFDlen, %object
	.size	dwnsSFDlen, 3
dwnsSFDlen:
	.byte	64
	.byte	16
	.byte	8
	.section	.rodata.fs_pll_cfg,"a"
	.align	2
	.type	fs_pll_cfg, %object
	.size	fs_pll_cfg, 24
fs_pll_cfg:
	.word	150995975
	.word	138413320
	.word	138416137
	.word	138413320
	.word	134218781
	.word	134218781
	.section	.rodata.fs_pll_tune,"a"
	.align	2
	.type	fs_pll_tune, %object
	.size	fs_pll_tune, 6
fs_pll_tune:
	.byte	30
	.byte	38
	.byte	86
	.byte	38
	.byte	-66
	.byte	-66
	.section	.rodata.lde_replicaCoeff,"a"
	.align	2
	.type	lde_replicaCoeff, %object
	.size	lde_replicaCoeff, 50
lde_replicaCoeff:
	.short	0
	.short	22936
	.short	22936
	.short	20970
	.short	17038
	.short	17694
	.short	11796
	.short	-32768
	.short	20970
	.short	10484
	.short	13106
	.short	15072
	.short	15728
	.short	15072
	.short	13762
	.short	11140
	.short	13762
	.short	13106
	.short	13762
	.short	13762
	.short	18350
	.short	15072
	.short	14416
	.short	12450
	.short	14416
	.section	.rodata.rx_config,"a"
	.align	2
	.type	rx_config, %object
	.size	rx_config, 2
rx_config:
	.byte	-40
	.byte	-68
	.section	.rodata.sftsh,"a"
	.align	2
	.type	sftsh, %object
	.size	sftsh, 12
sftsh:
	.short	10
	.short	22
	.short	1
	.short	6
	.short	1
	.short	2
	.section	.rodata.tx_config,"a"
	.align	2
	.type	tx_config, %object
	.size	tx_config, 24
tx_config:
	.word	23616
	.word	285856
	.word	552128
	.word	285824
	.word	1982432
	.word	1998304
	.section	.rodata.txpwr_compensation,"a"
	.align	3
	.type	txpwr_compensation, %object
	.size	txpwr_compensation, 48
txpwr_compensation:
	.word	0
	.word	0
	.word	515396076
	.word	1067576197
	.word	0
	.word	0
	.word	0
	.word	0
	.word	171798692
	.word	1068540887
	.word	0
	.word	0
	.ident	"GCC: (GNU) 8.2.1 20181213 (release) [gcc-8-branch revision 267074]"
