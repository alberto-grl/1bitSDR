// qsys_block.v

// Generated using ACDS version 13.1 182 at 2020.05.21.10:07:04

`timescale 1 ps / 1 ps
module qsys_block (
		input  wire        system_clock_clk,            //        system_clock.clk
		input  wire        system_clock_sreset_reset_n, // system_clock_sreset.reset_n
		output wire [11:0] sdram_addr,                  //               sdram.addr
		output wire [1:0]  sdram_ba,                    //                    .ba
		output wire        sdram_cas_n,                 //                    .cas_n
		output wire        sdram_cke,                   //                    .cke
		output wire        sdram_cs_n,                  //                    .cs_n
		inout  wire [15:0] sdram_dq,                    //                    .dq
		output wire [1:0]  sdram_dqm,                   //                    .dqm
		output wire        sdram_ras_n,                 //                    .ras_n
		output wire        sdram_we_n,                  //                    .we_n
		output wire [3:0]  cic_gain_export,             //            cic_gain.export
		output wire [31:0] phase_increment_export,      //     phase_increment.export
		input  wire        ps2_clk,                     //                 ps2.clk
		input  wire        ps2_dat                      //                    .dat
	);

	wire         nios_instruction_master_waitrequest;                       // mm_interconnect_0:NIOS_instruction_master_waitrequest -> NIOS:i_waitrequest
	wire  [23:0] nios_instruction_master_address;                           // NIOS:i_address -> mm_interconnect_0:NIOS_instruction_master_address
	wire         nios_instruction_master_read;                              // NIOS:i_read -> mm_interconnect_0:NIOS_instruction_master_read
	wire  [31:0] nios_instruction_master_readdata;                          // mm_interconnect_0:NIOS_instruction_master_readdata -> NIOS:i_readdata
	wire         nios_data_master_waitrequest;                              // mm_interconnect_0:NIOS_data_master_waitrequest -> NIOS:d_waitrequest
	wire  [31:0] nios_data_master_writedata;                                // NIOS:d_writedata -> mm_interconnect_0:NIOS_data_master_writedata
	wire  [23:0] nios_data_master_address;                                  // NIOS:d_address -> mm_interconnect_0:NIOS_data_master_address
	wire         nios_data_master_write;                                    // NIOS:d_write -> mm_interconnect_0:NIOS_data_master_write
	wire         nios_data_master_read;                                     // NIOS:d_read -> mm_interconnect_0:NIOS_data_master_read
	wire  [31:0] nios_data_master_readdata;                                 // mm_interconnect_0:NIOS_data_master_readdata -> NIOS:d_readdata
	wire         nios_data_master_debugaccess;                              // NIOS:jtag_debug_module_debugaccess_to_roms -> mm_interconnect_0:NIOS_data_master_debugaccess
	wire   [3:0] nios_data_master_byteenable;                               // NIOS:d_byteenable -> mm_interconnect_0:NIOS_data_master_byteenable
	wire  [31:0] mm_interconnect_0_cic_gain_s1_writedata;                   // mm_interconnect_0:cic_gain_s1_writedata -> cic_gain:writedata
	wire   [1:0] mm_interconnect_0_cic_gain_s1_address;                     // mm_interconnect_0:cic_gain_s1_address -> cic_gain:address
	wire         mm_interconnect_0_cic_gain_s1_chipselect;                  // mm_interconnect_0:cic_gain_s1_chipselect -> cic_gain:chipselect
	wire         mm_interconnect_0_cic_gain_s1_write;                       // mm_interconnect_0:cic_gain_s1_write -> cic_gain:write_n
	wire  [31:0] mm_interconnect_0_cic_gain_s1_readdata;                    // cic_gain:readdata -> mm_interconnect_0:cic_gain_s1_readdata
	wire         mm_interconnect_0_jtag_uart_avalon_jtag_slave_waitrequest; // jtag_uart:av_waitrequest -> mm_interconnect_0:jtag_uart_avalon_jtag_slave_waitrequest
	wire  [31:0] mm_interconnect_0_jtag_uart_avalon_jtag_slave_writedata;   // mm_interconnect_0:jtag_uart_avalon_jtag_slave_writedata -> jtag_uart:av_writedata
	wire   [0:0] mm_interconnect_0_jtag_uart_avalon_jtag_slave_address;     // mm_interconnect_0:jtag_uart_avalon_jtag_slave_address -> jtag_uart:av_address
	wire         mm_interconnect_0_jtag_uart_avalon_jtag_slave_chipselect;  // mm_interconnect_0:jtag_uart_avalon_jtag_slave_chipselect -> jtag_uart:av_chipselect
	wire         mm_interconnect_0_jtag_uart_avalon_jtag_slave_write;       // mm_interconnect_0:jtag_uart_avalon_jtag_slave_write -> jtag_uart:av_write_n
	wire         mm_interconnect_0_jtag_uart_avalon_jtag_slave_read;        // mm_interconnect_0:jtag_uart_avalon_jtag_slave_read -> jtag_uart:av_read_n
	wire  [31:0] mm_interconnect_0_jtag_uart_avalon_jtag_slave_readdata;    // jtag_uart:av_readdata -> mm_interconnect_0:jtag_uart_avalon_jtag_slave_readdata
	wire         mm_interconnect_0_ps2_slave_waitrequest;                   // ps2:s_waitrequest -> mm_interconnect_0:ps2_slave_waitrequest
	wire  [31:0] mm_interconnect_0_ps2_slave_writedata;                     // mm_interconnect_0:ps2_slave_writedata -> ps2:s_writedata
	wire   [3:0] mm_interconnect_0_ps2_slave_address;                       // mm_interconnect_0:ps2_slave_address -> ps2:s_address
	wire         mm_interconnect_0_ps2_slave_write;                         // mm_interconnect_0:ps2_slave_write -> ps2:s_write
	wire         mm_interconnect_0_ps2_slave_read;                          // mm_interconnect_0:ps2_slave_read -> ps2:s_read
	wire  [31:0] mm_interconnect_0_ps2_slave_readdata;                      // ps2:s_readdata -> mm_interconnect_0:ps2_slave_readdata
	wire         mm_interconnect_0_nios_jtag_debug_module_waitrequest;      // NIOS:jtag_debug_module_waitrequest -> mm_interconnect_0:NIOS_jtag_debug_module_waitrequest
	wire  [31:0] mm_interconnect_0_nios_jtag_debug_module_writedata;        // mm_interconnect_0:NIOS_jtag_debug_module_writedata -> NIOS:jtag_debug_module_writedata
	wire   [8:0] mm_interconnect_0_nios_jtag_debug_module_address;          // mm_interconnect_0:NIOS_jtag_debug_module_address -> NIOS:jtag_debug_module_address
	wire         mm_interconnect_0_nios_jtag_debug_module_write;            // mm_interconnect_0:NIOS_jtag_debug_module_write -> NIOS:jtag_debug_module_write
	wire         mm_interconnect_0_nios_jtag_debug_module_read;             // mm_interconnect_0:NIOS_jtag_debug_module_read -> NIOS:jtag_debug_module_read
	wire  [31:0] mm_interconnect_0_nios_jtag_debug_module_readdata;         // NIOS:jtag_debug_module_readdata -> mm_interconnect_0:NIOS_jtag_debug_module_readdata
	wire         mm_interconnect_0_nios_jtag_debug_module_debugaccess;      // mm_interconnect_0:NIOS_jtag_debug_module_debugaccess -> NIOS:jtag_debug_module_debugaccess
	wire   [3:0] mm_interconnect_0_nios_jtag_debug_module_byteenable;       // mm_interconnect_0:NIOS_jtag_debug_module_byteenable -> NIOS:jtag_debug_module_byteenable
	wire         mm_interconnect_0_sdram_s1_waitrequest;                    // sdram:za_waitrequest -> mm_interconnect_0:sdram_s1_waitrequest
	wire  [15:0] mm_interconnect_0_sdram_s1_writedata;                      // mm_interconnect_0:sdram_s1_writedata -> sdram:az_data
	wire  [21:0] mm_interconnect_0_sdram_s1_address;                        // mm_interconnect_0:sdram_s1_address -> sdram:az_addr
	wire         mm_interconnect_0_sdram_s1_chipselect;                     // mm_interconnect_0:sdram_s1_chipselect -> sdram:az_cs
	wire         mm_interconnect_0_sdram_s1_write;                          // mm_interconnect_0:sdram_s1_write -> sdram:az_wr_n
	wire         mm_interconnect_0_sdram_s1_read;                           // mm_interconnect_0:sdram_s1_read -> sdram:az_rd_n
	wire  [15:0] mm_interconnect_0_sdram_s1_readdata;                       // sdram:za_data -> mm_interconnect_0:sdram_s1_readdata
	wire         mm_interconnect_0_sdram_s1_readdatavalid;                  // sdram:za_valid -> mm_interconnect_0:sdram_s1_readdatavalid
	wire   [1:0] mm_interconnect_0_sdram_s1_byteenable;                     // mm_interconnect_0:sdram_s1_byteenable -> sdram:az_be_n
	wire  [31:0] mm_interconnect_0_onchip_ram_s1_writedata;                 // mm_interconnect_0:onchip_ram_s1_writedata -> onchip_ram:writedata
	wire  [11:0] mm_interconnect_0_onchip_ram_s1_address;                   // mm_interconnect_0:onchip_ram_s1_address -> onchip_ram:address
	wire         mm_interconnect_0_onchip_ram_s1_chipselect;                // mm_interconnect_0:onchip_ram_s1_chipselect -> onchip_ram:chipselect
	wire         mm_interconnect_0_onchip_ram_s1_clken;                     // mm_interconnect_0:onchip_ram_s1_clken -> onchip_ram:clken
	wire         mm_interconnect_0_onchip_ram_s1_write;                     // mm_interconnect_0:onchip_ram_s1_write -> onchip_ram:write
	wire  [31:0] mm_interconnect_0_onchip_ram_s1_readdata;                  // onchip_ram:readdata -> mm_interconnect_0:onchip_ram_s1_readdata
	wire   [3:0] mm_interconnect_0_onchip_ram_s1_byteenable;                // mm_interconnect_0:onchip_ram_s1_byteenable -> onchip_ram:byteenable
	wire  [31:0] mm_interconnect_0_phase_increment_s1_writedata;            // mm_interconnect_0:phase_increment_s1_writedata -> phase_increment:writedata
	wire   [1:0] mm_interconnect_0_phase_increment_s1_address;              // mm_interconnect_0:phase_increment_s1_address -> phase_increment:address
	wire         mm_interconnect_0_phase_increment_s1_chipselect;           // mm_interconnect_0:phase_increment_s1_chipselect -> phase_increment:chipselect
	wire         mm_interconnect_0_phase_increment_s1_write;                // mm_interconnect_0:phase_increment_s1_write -> phase_increment:write_n
	wire  [31:0] mm_interconnect_0_phase_increment_s1_readdata;             // phase_increment:readdata -> mm_interconnect_0:phase_increment_s1_readdata
	wire         irq_mapper_receiver0_irq;                                  // jtag_uart:av_irq -> irq_mapper:receiver0_irq
	wire         irq_mapper_receiver1_irq;                                  // ps2:irq -> irq_mapper:receiver1_irq
	wire  [31:0] nios_d_irq_irq;                                            // irq_mapper:sender_irq -> NIOS:d_irq
	wire         rst_controller_reset_out_reset;                            // rst_controller:reset_out -> [NIOS:reset_n, cic_gain:reset_n, irq_mapper:reset, jtag_uart:rst_n, mm_interconnect_0:NIOS_reset_n_reset_bridge_in_reset_reset, mm_interconnect_0:ps2_clock_sreset_reset_bridge_in_reset_reset, onchip_ram:reset, phase_increment:reset_n, rst_translator:in_reset, sdram:reset_n]
	wire         rst_controller_reset_out_reset_req;                        // rst_controller:reset_req -> [NIOS:reset_req, onchip_ram:reset_req, rst_translator:reset_req_in]

	qsys_block_NIOS nios (
		.clk                                   (system_clock_clk),                                     //                       clk.clk
		.reset_n                               (~rst_controller_reset_out_reset),                      //                   reset_n.reset_n
		.reset_req                             (rst_controller_reset_out_reset_req),                   //                          .reset_req
		.d_address                             (nios_data_master_address),                             //               data_master.address
		.d_byteenable                          (nios_data_master_byteenable),                          //                          .byteenable
		.d_read                                (nios_data_master_read),                                //                          .read
		.d_readdata                            (nios_data_master_readdata),                            //                          .readdata
		.d_waitrequest                         (nios_data_master_waitrequest),                         //                          .waitrequest
		.d_write                               (nios_data_master_write),                               //                          .write
		.d_writedata                           (nios_data_master_writedata),                           //                          .writedata
		.jtag_debug_module_debugaccess_to_roms (nios_data_master_debugaccess),                         //                          .debugaccess
		.i_address                             (nios_instruction_master_address),                      //        instruction_master.address
		.i_read                                (nios_instruction_master_read),                         //                          .read
		.i_readdata                            (nios_instruction_master_readdata),                     //                          .readdata
		.i_waitrequest                         (nios_instruction_master_waitrequest),                  //                          .waitrequest
		.d_irq                                 (nios_d_irq_irq),                                       //                     d_irq.irq
		.jtag_debug_module_resetrequest        (),                                                     //   jtag_debug_module_reset.reset
		.jtag_debug_module_address             (mm_interconnect_0_nios_jtag_debug_module_address),     //         jtag_debug_module.address
		.jtag_debug_module_byteenable          (mm_interconnect_0_nios_jtag_debug_module_byteenable),  //                          .byteenable
		.jtag_debug_module_debugaccess         (mm_interconnect_0_nios_jtag_debug_module_debugaccess), //                          .debugaccess
		.jtag_debug_module_read                (mm_interconnect_0_nios_jtag_debug_module_read),        //                          .read
		.jtag_debug_module_readdata            (mm_interconnect_0_nios_jtag_debug_module_readdata),    //                          .readdata
		.jtag_debug_module_waitrequest         (mm_interconnect_0_nios_jtag_debug_module_waitrequest), //                          .waitrequest
		.jtag_debug_module_write               (mm_interconnect_0_nios_jtag_debug_module_write),       //                          .write
		.jtag_debug_module_writedata           (mm_interconnect_0_nios_jtag_debug_module_writedata),   //                          .writedata
		.no_ci_readra                          ()                                                      // custom_instruction_master.readra
	);

	qsys_block_jtag_uart jtag_uart (
		.clk            (system_clock_clk),                                          //               clk.clk
		.rst_n          (~rst_controller_reset_out_reset),                           //             reset.reset_n
		.av_chipselect  (mm_interconnect_0_jtag_uart_avalon_jtag_slave_chipselect),  // avalon_jtag_slave.chipselect
		.av_address     (mm_interconnect_0_jtag_uart_avalon_jtag_slave_address),     //                  .address
		.av_read_n      (~mm_interconnect_0_jtag_uart_avalon_jtag_slave_read),       //                  .read_n
		.av_readdata    (mm_interconnect_0_jtag_uart_avalon_jtag_slave_readdata),    //                  .readdata
		.av_write_n     (~mm_interconnect_0_jtag_uart_avalon_jtag_slave_write),      //                  .write_n
		.av_writedata   (mm_interconnect_0_jtag_uart_avalon_jtag_slave_writedata),   //                  .writedata
		.av_waitrequest (mm_interconnect_0_jtag_uart_avalon_jtag_slave_waitrequest), //                  .waitrequest
		.av_irq         (irq_mapper_receiver0_irq)                                   //               irq.irq
	);

	qsys_block_onchip_ram onchip_ram (
		.clk        (system_clock_clk),                           //   clk1.clk
		.address    (mm_interconnect_0_onchip_ram_s1_address),    //     s1.address
		.clken      (mm_interconnect_0_onchip_ram_s1_clken),      //       .clken
		.chipselect (mm_interconnect_0_onchip_ram_s1_chipselect), //       .chipselect
		.write      (mm_interconnect_0_onchip_ram_s1_write),      //       .write
		.readdata   (mm_interconnect_0_onchip_ram_s1_readdata),   //       .readdata
		.writedata  (mm_interconnect_0_onchip_ram_s1_writedata),  //       .writedata
		.byteenable (mm_interconnect_0_onchip_ram_s1_byteenable), //       .byteenable
		.reset      (rst_controller_reset_out_reset),             // reset1.reset
		.reset_req  (rst_controller_reset_out_reset_req)          //       .reset_req
	);

	qsys_block_sdram sdram (
		.clk            (system_clock_clk),                         //   clk.clk
		.reset_n        (~rst_controller_reset_out_reset),          // reset.reset_n
		.az_addr        (mm_interconnect_0_sdram_s1_address),       //    s1.address
		.az_be_n        (~mm_interconnect_0_sdram_s1_byteenable),   //      .byteenable_n
		.az_cs          (mm_interconnect_0_sdram_s1_chipselect),    //      .chipselect
		.az_data        (mm_interconnect_0_sdram_s1_writedata),     //      .writedata
		.az_rd_n        (~mm_interconnect_0_sdram_s1_read),         //      .read_n
		.az_wr_n        (~mm_interconnect_0_sdram_s1_write),        //      .write_n
		.za_data        (mm_interconnect_0_sdram_s1_readdata),      //      .readdata
		.za_valid       (mm_interconnect_0_sdram_s1_readdatavalid), //      .readdatavalid
		.za_waitrequest (mm_interconnect_0_sdram_s1_waitrequest),   //      .waitrequest
		.zs_addr        (sdram_addr),                               //  wire.export
		.zs_ba          (sdram_ba),                                 //      .export
		.zs_cas_n       (sdram_cas_n),                              //      .export
		.zs_cke         (sdram_cke),                                //      .export
		.zs_cs_n        (sdram_cs_n),                               //      .export
		.zs_dq          (sdram_dq),                                 //      .export
		.zs_dqm         (sdram_dqm),                                //      .export
		.zs_ras_n       (sdram_ras_n),                              //      .export
		.zs_we_n        (sdram_we_n)                                //      .export
	);

	qsys_block_cic_gain cic_gain (
		.clk        (system_clock_clk),                         //                 clk.clk
		.reset_n    (~rst_controller_reset_out_reset),          //               reset.reset_n
		.address    (mm_interconnect_0_cic_gain_s1_address),    //                  s1.address
		.write_n    (~mm_interconnect_0_cic_gain_s1_write),     //                    .write_n
		.writedata  (mm_interconnect_0_cic_gain_s1_writedata),  //                    .writedata
		.chipselect (mm_interconnect_0_cic_gain_s1_chipselect), //                    .chipselect
		.readdata   (mm_interconnect_0_cic_gain_s1_readdata),   //                    .readdata
		.out_port   (cic_gain_export)                           // external_connection.export
	);

	qsys_block_phase_increment phase_increment (
		.clk        (system_clock_clk),                                //                 clk.clk
		.reset_n    (~rst_controller_reset_out_reset),                 //               reset.reset_n
		.address    (mm_interconnect_0_phase_increment_s1_address),    //                  s1.address
		.write_n    (~mm_interconnect_0_phase_increment_s1_write),     //                    .write_n
		.writedata  (mm_interconnect_0_phase_increment_s1_writedata),  //                    .writedata
		.chipselect (mm_interconnect_0_phase_increment_s1_chipselect), //                    .chipselect
		.readdata   (mm_interconnect_0_phase_increment_s1_readdata),   //                    .readdata
		.out_port   (phase_increment_export)                           // external_connection.export
	);

	ps2_keyboard #(
		.SYSTEM_CLOCK (100000000)
	) ps2 (
		.clock         (system_clock_clk),                        //        clock.clk
		.clock_sreset  (~system_clock_sreset_reset_n),            // clock_sreset.reset
		.ps2_clk       (ps2_clk),                                 //          PS2.export
		.ps2_dat       (ps2_dat),                                 //             .export
		.s_address     (mm_interconnect_0_ps2_slave_address),     //        slave.address
		.s_writedata   (mm_interconnect_0_ps2_slave_writedata),   //             .writedata
		.s_readdata    (mm_interconnect_0_ps2_slave_readdata),    //             .readdata
		.s_read        (mm_interconnect_0_ps2_slave_read),        //             .read
		.s_write       (mm_interconnect_0_ps2_slave_write),       //             .write
		.s_waitrequest (mm_interconnect_0_ps2_slave_waitrequest), //             .waitrequest
		.irq           (irq_mapper_receiver1_irq)                 //          irq.irq
	);

	qsys_block_mm_interconnect_0 mm_interconnect_0 (
		.clock_clk_clk                                (system_clock_clk),                                          //                              clock_clk.clk
		.NIOS_reset_n_reset_bridge_in_reset_reset     (rst_controller_reset_out_reset),                            //     NIOS_reset_n_reset_bridge_in_reset.reset
		.ps2_clock_sreset_reset_bridge_in_reset_reset (rst_controller_reset_out_reset),                            // ps2_clock_sreset_reset_bridge_in_reset.reset
		.NIOS_data_master_address                     (nios_data_master_address),                                  //                       NIOS_data_master.address
		.NIOS_data_master_waitrequest                 (nios_data_master_waitrequest),                              //                                       .waitrequest
		.NIOS_data_master_byteenable                  (nios_data_master_byteenable),                               //                                       .byteenable
		.NIOS_data_master_read                        (nios_data_master_read),                                     //                                       .read
		.NIOS_data_master_readdata                    (nios_data_master_readdata),                                 //                                       .readdata
		.NIOS_data_master_write                       (nios_data_master_write),                                    //                                       .write
		.NIOS_data_master_writedata                   (nios_data_master_writedata),                                //                                       .writedata
		.NIOS_data_master_debugaccess                 (nios_data_master_debugaccess),                              //                                       .debugaccess
		.NIOS_instruction_master_address              (nios_instruction_master_address),                           //                NIOS_instruction_master.address
		.NIOS_instruction_master_waitrequest          (nios_instruction_master_waitrequest),                       //                                       .waitrequest
		.NIOS_instruction_master_read                 (nios_instruction_master_read),                              //                                       .read
		.NIOS_instruction_master_readdata             (nios_instruction_master_readdata),                          //                                       .readdata
		.cic_gain_s1_address                          (mm_interconnect_0_cic_gain_s1_address),                     //                            cic_gain_s1.address
		.cic_gain_s1_write                            (mm_interconnect_0_cic_gain_s1_write),                       //                                       .write
		.cic_gain_s1_readdata                         (mm_interconnect_0_cic_gain_s1_readdata),                    //                                       .readdata
		.cic_gain_s1_writedata                        (mm_interconnect_0_cic_gain_s1_writedata),                   //                                       .writedata
		.cic_gain_s1_chipselect                       (mm_interconnect_0_cic_gain_s1_chipselect),                  //                                       .chipselect
		.jtag_uart_avalon_jtag_slave_address          (mm_interconnect_0_jtag_uart_avalon_jtag_slave_address),     //            jtag_uart_avalon_jtag_slave.address
		.jtag_uart_avalon_jtag_slave_write            (mm_interconnect_0_jtag_uart_avalon_jtag_slave_write),       //                                       .write
		.jtag_uart_avalon_jtag_slave_read             (mm_interconnect_0_jtag_uart_avalon_jtag_slave_read),        //                                       .read
		.jtag_uart_avalon_jtag_slave_readdata         (mm_interconnect_0_jtag_uart_avalon_jtag_slave_readdata),    //                                       .readdata
		.jtag_uart_avalon_jtag_slave_writedata        (mm_interconnect_0_jtag_uart_avalon_jtag_slave_writedata),   //                                       .writedata
		.jtag_uart_avalon_jtag_slave_waitrequest      (mm_interconnect_0_jtag_uart_avalon_jtag_slave_waitrequest), //                                       .waitrequest
		.jtag_uart_avalon_jtag_slave_chipselect       (mm_interconnect_0_jtag_uart_avalon_jtag_slave_chipselect),  //                                       .chipselect
		.NIOS_jtag_debug_module_address               (mm_interconnect_0_nios_jtag_debug_module_address),          //                 NIOS_jtag_debug_module.address
		.NIOS_jtag_debug_module_write                 (mm_interconnect_0_nios_jtag_debug_module_write),            //                                       .write
		.NIOS_jtag_debug_module_read                  (mm_interconnect_0_nios_jtag_debug_module_read),             //                                       .read
		.NIOS_jtag_debug_module_readdata              (mm_interconnect_0_nios_jtag_debug_module_readdata),         //                                       .readdata
		.NIOS_jtag_debug_module_writedata             (mm_interconnect_0_nios_jtag_debug_module_writedata),        //                                       .writedata
		.NIOS_jtag_debug_module_byteenable            (mm_interconnect_0_nios_jtag_debug_module_byteenable),       //                                       .byteenable
		.NIOS_jtag_debug_module_waitrequest           (mm_interconnect_0_nios_jtag_debug_module_waitrequest),      //                                       .waitrequest
		.NIOS_jtag_debug_module_debugaccess           (mm_interconnect_0_nios_jtag_debug_module_debugaccess),      //                                       .debugaccess
		.onchip_ram_s1_address                        (mm_interconnect_0_onchip_ram_s1_address),                   //                          onchip_ram_s1.address
		.onchip_ram_s1_write                          (mm_interconnect_0_onchip_ram_s1_write),                     //                                       .write
		.onchip_ram_s1_readdata                       (mm_interconnect_0_onchip_ram_s1_readdata),                  //                                       .readdata
		.onchip_ram_s1_writedata                      (mm_interconnect_0_onchip_ram_s1_writedata),                 //                                       .writedata
		.onchip_ram_s1_byteenable                     (mm_interconnect_0_onchip_ram_s1_byteenable),                //                                       .byteenable
		.onchip_ram_s1_chipselect                     (mm_interconnect_0_onchip_ram_s1_chipselect),                //                                       .chipselect
		.onchip_ram_s1_clken                          (mm_interconnect_0_onchip_ram_s1_clken),                     //                                       .clken
		.phase_increment_s1_address                   (mm_interconnect_0_phase_increment_s1_address),              //                     phase_increment_s1.address
		.phase_increment_s1_write                     (mm_interconnect_0_phase_increment_s1_write),                //                                       .write
		.phase_increment_s1_readdata                  (mm_interconnect_0_phase_increment_s1_readdata),             //                                       .readdata
		.phase_increment_s1_writedata                 (mm_interconnect_0_phase_increment_s1_writedata),            //                                       .writedata
		.phase_increment_s1_chipselect                (mm_interconnect_0_phase_increment_s1_chipselect),           //                                       .chipselect
		.ps2_slave_address                            (mm_interconnect_0_ps2_slave_address),                       //                              ps2_slave.address
		.ps2_slave_write                              (mm_interconnect_0_ps2_slave_write),                         //                                       .write
		.ps2_slave_read                               (mm_interconnect_0_ps2_slave_read),                          //                                       .read
		.ps2_slave_readdata                           (mm_interconnect_0_ps2_slave_readdata),                      //                                       .readdata
		.ps2_slave_writedata                          (mm_interconnect_0_ps2_slave_writedata),                     //                                       .writedata
		.ps2_slave_waitrequest                        (mm_interconnect_0_ps2_slave_waitrequest),                   //                                       .waitrequest
		.sdram_s1_address                             (mm_interconnect_0_sdram_s1_address),                        //                               sdram_s1.address
		.sdram_s1_write                               (mm_interconnect_0_sdram_s1_write),                          //                                       .write
		.sdram_s1_read                                (mm_interconnect_0_sdram_s1_read),                           //                                       .read
		.sdram_s1_readdata                            (mm_interconnect_0_sdram_s1_readdata),                       //                                       .readdata
		.sdram_s1_writedata                           (mm_interconnect_0_sdram_s1_writedata),                      //                                       .writedata
		.sdram_s1_byteenable                          (mm_interconnect_0_sdram_s1_byteenable),                     //                                       .byteenable
		.sdram_s1_readdatavalid                       (mm_interconnect_0_sdram_s1_readdatavalid),                  //                                       .readdatavalid
		.sdram_s1_waitrequest                         (mm_interconnect_0_sdram_s1_waitrequest),                    //                                       .waitrequest
		.sdram_s1_chipselect                          (mm_interconnect_0_sdram_s1_chipselect)                      //                                       .chipselect
	);

	qsys_block_irq_mapper irq_mapper (
		.clk           (system_clock_clk),               //       clk.clk
		.reset         (rst_controller_reset_out_reset), // clk_reset.reset
		.receiver0_irq (irq_mapper_receiver0_irq),       // receiver0.irq
		.receiver1_irq (irq_mapper_receiver1_irq),       // receiver1.irq
		.sender_irq    (nios_d_irq_irq)                  //    sender.irq
	);

	altera_reset_controller #(
		.NUM_RESET_INPUTS          (1),
		.OUTPUT_RESET_SYNC_EDGES   ("deassert"),
		.SYNC_DEPTH                (2),
		.RESET_REQUEST_PRESENT     (1),
		.RESET_REQ_WAIT_TIME       (1),
		.MIN_RST_ASSERTION_TIME    (3),
		.RESET_REQ_EARLY_DSRT_TIME (1),
		.USE_RESET_REQUEST_IN0     (0),
		.USE_RESET_REQUEST_IN1     (0),
		.USE_RESET_REQUEST_IN2     (0),
		.USE_RESET_REQUEST_IN3     (0),
		.USE_RESET_REQUEST_IN4     (0),
		.USE_RESET_REQUEST_IN5     (0),
		.USE_RESET_REQUEST_IN6     (0),
		.USE_RESET_REQUEST_IN7     (0),
		.USE_RESET_REQUEST_IN8     (0),
		.USE_RESET_REQUEST_IN9     (0),
		.USE_RESET_REQUEST_IN10    (0),
		.USE_RESET_REQUEST_IN11    (0),
		.USE_RESET_REQUEST_IN12    (0),
		.USE_RESET_REQUEST_IN13    (0),
		.USE_RESET_REQUEST_IN14    (0),
		.USE_RESET_REQUEST_IN15    (0),
		.ADAPT_RESET_REQUEST       (0)
	) rst_controller (
		.reset_in0      (~system_clock_sreset_reset_n),       // reset_in0.reset
		.clk            (system_clock_clk),                   //       clk.clk
		.reset_out      (rst_controller_reset_out_reset),     // reset_out.reset
		.reset_req      (rst_controller_reset_out_reset_req), //          .reset_req
		.reset_req_in0  (1'b0),                               // (terminated)
		.reset_in1      (1'b0),                               // (terminated)
		.reset_req_in1  (1'b0),                               // (terminated)
		.reset_in2      (1'b0),                               // (terminated)
		.reset_req_in2  (1'b0),                               // (terminated)
		.reset_in3      (1'b0),                               // (terminated)
		.reset_req_in3  (1'b0),                               // (terminated)
		.reset_in4      (1'b0),                               // (terminated)
		.reset_req_in4  (1'b0),                               // (terminated)
		.reset_in5      (1'b0),                               // (terminated)
		.reset_req_in5  (1'b0),                               // (terminated)
		.reset_in6      (1'b0),                               // (terminated)
		.reset_req_in6  (1'b0),                               // (terminated)
		.reset_in7      (1'b0),                               // (terminated)
		.reset_req_in7  (1'b0),                               // (terminated)
		.reset_in8      (1'b0),                               // (terminated)
		.reset_req_in8  (1'b0),                               // (terminated)
		.reset_in9      (1'b0),                               // (terminated)
		.reset_req_in9  (1'b0),                               // (terminated)
		.reset_in10     (1'b0),                               // (terminated)
		.reset_req_in10 (1'b0),                               // (terminated)
		.reset_in11     (1'b0),                               // (terminated)
		.reset_req_in11 (1'b0),                               // (terminated)
		.reset_in12     (1'b0),                               // (terminated)
		.reset_req_in12 (1'b0),                               // (terminated)
		.reset_in13     (1'b0),                               // (terminated)
		.reset_req_in13 (1'b0),                               // (terminated)
		.reset_in14     (1'b0),                               // (terminated)
		.reset_req_in14 (1'b0),                               // (terminated)
		.reset_in15     (1'b0),                               // (terminated)
		.reset_req_in15 (1'b0)                                // (terminated)
	);

endmodule