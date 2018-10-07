// THIS FILE IS AUTOGENERATED BY wb_intercon_gen
// ANY MANUAL CHANGES WILL BE LOST
module wb_intercon
   (input         wb_clk_i,
    input         wb_rst_i,
    input  [31:0] wb_picorv32_adr_i,
    input  [31:0] wb_picorv32_dat_i,
    input   [3:0] wb_picorv32_sel_i,
    input         wb_picorv32_we_i,
    input         wb_picorv32_cyc_i,
    input         wb_picorv32_stb_i,
    input   [2:0] wb_picorv32_cti_i,
    input   [1:0] wb_picorv32_bte_i,
    output [31:0] wb_picorv32_dat_o,
    output        wb_picorv32_ack_o,
    output        wb_picorv32_err_o,
    output        wb_picorv32_rty_o,
    input  [31:0] wb_streamer_master_adr_i,
    input  [31:0] wb_streamer_master_dat_i,
    input   [3:0] wb_streamer_master_sel_i,
    input         wb_streamer_master_we_i,
    input         wb_streamer_master_cyc_i,
    input         wb_streamer_master_stb_i,
    input   [2:0] wb_streamer_master_cti_i,
    input   [1:0] wb_streamer_master_bte_i,
    output [31:0] wb_streamer_master_dat_o,
    output        wb_streamer_master_ack_o,
    output        wb_streamer_master_err_o,
    output        wb_streamer_master_rty_o,
    input  [31:0] wb_sdc_master_adr_i,
    input  [31:0] wb_sdc_master_dat_i,
    input   [3:0] wb_sdc_master_sel_i,
    input         wb_sdc_master_we_i,
    input         wb_sdc_master_cyc_i,
    input         wb_sdc_master_stb_i,
    input   [2:0] wb_sdc_master_cti_i,
    input   [1:0] wb_sdc_master_bte_i,
    output [31:0] wb_sdc_master_dat_o,
    output        wb_sdc_master_ack_o,
    output        wb_sdc_master_err_o,
    output        wb_sdc_master_rty_o,
    output [31:0] wb_ram0_adr_o,
    output [31:0] wb_ram0_dat_o,
    output  [3:0] wb_ram0_sel_o,
    output        wb_ram0_we_o,
    output        wb_ram0_cyc_o,
    output        wb_ram0_stb_o,
    output  [2:0] wb_ram0_cti_o,
    output  [1:0] wb_ram0_bte_o,
    input  [31:0] wb_ram0_dat_i,
    input         wb_ram0_ack_i,
    input         wb_ram0_err_i,
    input         wb_ram0_rty_i,
    output [31:0] wb_flash0_adr_o,
    output [31:0] wb_flash0_dat_o,
    output  [3:0] wb_flash0_sel_o,
    output        wb_flash0_we_o,
    output        wb_flash0_cyc_o,
    output        wb_flash0_stb_o,
    output  [2:0] wb_flash0_cti_o,
    output  [1:0] wb_flash0_bte_o,
    input  [31:0] wb_flash0_dat_i,
    input         wb_flash0_ack_i,
    input         wb_flash0_err_i,
    input         wb_flash0_rty_i,
    output [31:0] wb_spi_conf_adr_o,
    output [31:0] wb_spi_conf_dat_o,
    output  [3:0] wb_spi_conf_sel_o,
    output        wb_spi_conf_we_o,
    output        wb_spi_conf_cyc_o,
    output        wb_spi_conf_stb_o,
    output  [2:0] wb_spi_conf_cti_o,
    output  [1:0] wb_spi_conf_bte_o,
    input  [31:0] wb_spi_conf_dat_i,
    input         wb_spi_conf_ack_i,
    input         wb_spi_conf_err_i,
    input         wb_spi_conf_rty_i,
    output [31:0] wb_gpio0_adr_o,
    output [31:0] wb_gpio0_dat_o,
    output  [3:0] wb_gpio0_sel_o,
    output        wb_gpio0_we_o,
    output        wb_gpio0_cyc_o,
    output        wb_gpio0_stb_o,
    output  [2:0] wb_gpio0_cti_o,
    output  [1:0] wb_gpio0_bte_o,
    input  [31:0] wb_gpio0_dat_i,
    input         wb_gpio0_ack_i,
    input         wb_gpio0_err_i,
    input         wb_gpio0_rty_i,
    output [31:0] wb_uart0_adr_o,
    output [31:0] wb_uart0_dat_o,
    output  [3:0] wb_uart0_sel_o,
    output        wb_uart0_we_o,
    output        wb_uart0_cyc_o,
    output        wb_uart0_stb_o,
    output  [2:0] wb_uart0_cti_o,
    output  [1:0] wb_uart0_bte_o,
    input  [31:0] wb_uart0_dat_i,
    input         wb_uart0_ack_i,
    input         wb_uart0_err_i,
    input         wb_uart0_rty_i,
    output [31:0] wb_uart1_adr_o,
    output [31:0] wb_uart1_dat_o,
    output  [3:0] wb_uart1_sel_o,
    output        wb_uart1_we_o,
    output        wb_uart1_cyc_o,
    output        wb_uart1_stb_o,
    output  [2:0] wb_uart1_cti_o,
    output  [1:0] wb_uart1_bte_o,
    input  [31:0] wb_uart1_dat_i,
    input         wb_uart1_ack_i,
    input         wb_uart1_err_i,
    input         wb_uart1_rty_i,
    output [31:0] wb_reset0_adr_o,
    output [31:0] wb_reset0_dat_o,
    output  [3:0] wb_reset0_sel_o,
    output        wb_reset0_we_o,
    output        wb_reset0_cyc_o,
    output        wb_reset0_stb_o,
    output  [2:0] wb_reset0_cti_o,
    output  [1:0] wb_reset0_bte_o,
    input  [31:0] wb_reset0_dat_i,
    input         wb_reset0_ack_i,
    input         wb_reset0_err_i,
    input         wb_reset0_rty_i,
    output [31:0] wb_sdc_slave_adr_o,
    output [31:0] wb_sdc_slave_dat_o,
    output  [3:0] wb_sdc_slave_sel_o,
    output        wb_sdc_slave_we_o,
    output        wb_sdc_slave_cyc_o,
    output        wb_sdc_slave_stb_o,
    output  [2:0] wb_sdc_slave_cti_o,
    output  [1:0] wb_sdc_slave_bte_o,
    input  [31:0] wb_sdc_slave_dat_i,
    input         wb_sdc_slave_ack_i,
    input         wb_sdc_slave_err_i,
    input         wb_sdc_slave_rty_i,
    output [31:0] wb_streamer_adr_o,
    output [31:0] wb_streamer_dat_o,
    output  [3:0] wb_streamer_sel_o,
    output        wb_streamer_we_o,
    output        wb_streamer_cyc_o,
    output        wb_streamer_stb_o,
    output  [2:0] wb_streamer_cti_o,
    output  [1:0] wb_streamer_bte_o,
    input  [31:0] wb_streamer_dat_i,
    input         wb_streamer_ack_i,
    input         wb_streamer_err_i,
    input         wb_streamer_rty_i,
    output [31:0] wb_cc_cfg_adr_o,
    output [31:0] wb_cc_cfg_dat_o,
    output  [3:0] wb_cc_cfg_sel_o,
    output        wb_cc_cfg_we_o,
    output        wb_cc_cfg_cyc_o,
    output        wb_cc_cfg_stb_o,
    output  [2:0] wb_cc_cfg_cti_o,
    output  [1:0] wb_cc_cfg_bte_o,
    input  [31:0] wb_cc_cfg_dat_i,
    input         wb_cc_cfg_ack_i,
    input         wb_cc_cfg_err_i,
    input         wb_cc_cfg_rty_i,
    output [31:0] wb_hram0_cfg_adr_o,
    output [31:0] wb_hram0_cfg_dat_o,
    output  [3:0] wb_hram0_cfg_sel_o,
    output        wb_hram0_cfg_we_o,
    output        wb_hram0_cfg_cyc_o,
    output        wb_hram0_cfg_stb_o,
    output  [2:0] wb_hram0_cfg_cti_o,
    output  [1:0] wb_hram0_cfg_bte_o,
    input  [31:0] wb_hram0_cfg_dat_i,
    input         wb_hram0_cfg_ack_i,
    input         wb_hram0_cfg_err_i,
    input         wb_hram0_cfg_rty_i,
    output [31:0] wb_hram0_adr_o,
    output [31:0] wb_hram0_dat_o,
    output  [3:0] wb_hram0_sel_o,
    output        wb_hram0_we_o,
    output        wb_hram0_cyc_o,
    output        wb_hram0_stb_o,
    output  [2:0] wb_hram0_cti_o,
    output  [1:0] wb_hram0_bte_o,
    input  [31:0] wb_hram0_dat_i,
    input         wb_hram0_ack_i,
    input         wb_hram0_err_i,
    input         wb_hram0_rty_i);

wire [31:0] wb_m2s_picorv32_ram0_adr;
wire [31:0] wb_m2s_picorv32_ram0_dat;
wire  [3:0] wb_m2s_picorv32_ram0_sel;
wire        wb_m2s_picorv32_ram0_we;
wire        wb_m2s_picorv32_ram0_cyc;
wire        wb_m2s_picorv32_ram0_stb;
wire  [2:0] wb_m2s_picorv32_ram0_cti;
wire  [1:0] wb_m2s_picorv32_ram0_bte;
wire [31:0] wb_s2m_picorv32_ram0_dat;
wire        wb_s2m_picorv32_ram0_ack;
wire        wb_s2m_picorv32_ram0_err;
wire        wb_s2m_picorv32_ram0_rty;
wire [31:0] wb_m2s_picorv32_hram0_adr;
wire [31:0] wb_m2s_picorv32_hram0_dat;
wire  [3:0] wb_m2s_picorv32_hram0_sel;
wire        wb_m2s_picorv32_hram0_we;
wire        wb_m2s_picorv32_hram0_cyc;
wire        wb_m2s_picorv32_hram0_stb;
wire  [2:0] wb_m2s_picorv32_hram0_cti;
wire  [1:0] wb_m2s_picorv32_hram0_bte;
wire [31:0] wb_s2m_picorv32_hram0_dat;
wire        wb_s2m_picorv32_hram0_ack;
wire        wb_s2m_picorv32_hram0_err;
wire        wb_s2m_picorv32_hram0_rty;
wire [31:0] wb_m2s_streamer_master_hram0_adr;
wire [31:0] wb_m2s_streamer_master_hram0_dat;
wire  [3:0] wb_m2s_streamer_master_hram0_sel;
wire        wb_m2s_streamer_master_hram0_we;
wire        wb_m2s_streamer_master_hram0_cyc;
wire        wb_m2s_streamer_master_hram0_stb;
wire  [2:0] wb_m2s_streamer_master_hram0_cti;
wire  [1:0] wb_m2s_streamer_master_hram0_bte;
wire [31:0] wb_s2m_streamer_master_hram0_dat;
wire        wb_s2m_streamer_master_hram0_ack;
wire        wb_s2m_streamer_master_hram0_err;
wire        wb_s2m_streamer_master_hram0_rty;
wire [31:0] wb_m2s_streamer_master_ram0_adr;
wire [31:0] wb_m2s_streamer_master_ram0_dat;
wire  [3:0] wb_m2s_streamer_master_ram0_sel;
wire        wb_m2s_streamer_master_ram0_we;
wire        wb_m2s_streamer_master_ram0_cyc;
wire        wb_m2s_streamer_master_ram0_stb;
wire  [2:0] wb_m2s_streamer_master_ram0_cti;
wire  [1:0] wb_m2s_streamer_master_ram0_bte;
wire [31:0] wb_s2m_streamer_master_ram0_dat;
wire        wb_s2m_streamer_master_ram0_ack;
wire        wb_s2m_streamer_master_ram0_err;
wire        wb_s2m_streamer_master_ram0_rty;
wire [31:0] wb_m2s_sdc_master_hram0_adr;
wire [31:0] wb_m2s_sdc_master_hram0_dat;
wire  [3:0] wb_m2s_sdc_master_hram0_sel;
wire        wb_m2s_sdc_master_hram0_we;
wire        wb_m2s_sdc_master_hram0_cyc;
wire        wb_m2s_sdc_master_hram0_stb;
wire  [2:0] wb_m2s_sdc_master_hram0_cti;
wire  [1:0] wb_m2s_sdc_master_hram0_bte;
wire [31:0] wb_s2m_sdc_master_hram0_dat;
wire        wb_s2m_sdc_master_hram0_ack;
wire        wb_s2m_sdc_master_hram0_err;
wire        wb_s2m_sdc_master_hram0_rty;
wire [31:0] wb_m2s_sdc_master_ram0_adr;
wire [31:0] wb_m2s_sdc_master_ram0_dat;
wire  [3:0] wb_m2s_sdc_master_ram0_sel;
wire        wb_m2s_sdc_master_ram0_we;
wire        wb_m2s_sdc_master_ram0_cyc;
wire        wb_m2s_sdc_master_ram0_stb;
wire  [2:0] wb_m2s_sdc_master_ram0_cti;
wire  [1:0] wb_m2s_sdc_master_ram0_bte;
wire [31:0] wb_s2m_sdc_master_ram0_dat;
wire        wb_s2m_sdc_master_ram0_ack;
wire        wb_s2m_sdc_master_ram0_err;
wire        wb_s2m_sdc_master_ram0_rty;

wb_mux
  #(.num_slaves (10),
    .MATCH_ADDR ({32'h00000000, 32'h01000000, 32'h04000000, 32'h02000000, 32'h02000200, 32'h02001100, 32'h02002000, 32'h02100000, 32'h02002100, 32'h02001300}),
    .MATCH_MASK ({32'hfff00000, 32'hffffc000, 32'hffe00000, 32'hffffff00, 32'hffffff00, 32'hffffff00, 32'hffffff00, 32'hffffff00, 32'hffffff00, 32'hffffff00}))
 wb_mux_picorv32
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i (wb_picorv32_adr_i),
    .wbm_dat_i (wb_picorv32_dat_i),
    .wbm_sel_i (wb_picorv32_sel_i),
    .wbm_we_i  (wb_picorv32_we_i),
    .wbm_cyc_i (wb_picorv32_cyc_i),
    .wbm_stb_i (wb_picorv32_stb_i),
    .wbm_cti_i (wb_picorv32_cti_i),
    .wbm_bte_i (wb_picorv32_bte_i),
    .wbm_dat_o (wb_picorv32_dat_o),
    .wbm_ack_o (wb_picorv32_ack_o),
    .wbm_err_o (wb_picorv32_err_o),
    .wbm_rty_o (wb_picorv32_rty_o),
    .wbs_adr_o ({wb_flash0_adr_o, wb_m2s_picorv32_ram0_adr, wb_m2s_picorv32_hram0_adr, wb_spi_conf_adr_o, wb_gpio0_adr_o, wb_uart0_adr_o, wb_streamer_adr_o, wb_sdc_slave_adr_o, wb_cc_cfg_adr_o, wb_reset0_adr_o}),
    .wbs_dat_o ({wb_flash0_dat_o, wb_m2s_picorv32_ram0_dat, wb_m2s_picorv32_hram0_dat, wb_spi_conf_dat_o, wb_gpio0_dat_o, wb_uart0_dat_o, wb_streamer_dat_o, wb_sdc_slave_dat_o, wb_cc_cfg_dat_o, wb_reset0_dat_o}),
    .wbs_sel_o ({wb_flash0_sel_o, wb_m2s_picorv32_ram0_sel, wb_m2s_picorv32_hram0_sel, wb_spi_conf_sel_o, wb_gpio0_sel_o, wb_uart0_sel_o, wb_streamer_sel_o, wb_sdc_slave_sel_o, wb_cc_cfg_sel_o, wb_reset0_sel_o}),
    .wbs_we_o  ({wb_flash0_we_o, wb_m2s_picorv32_ram0_we, wb_m2s_picorv32_hram0_we, wb_spi_conf_we_o, wb_gpio0_we_o, wb_uart0_we_o, wb_streamer_we_o, wb_sdc_slave_we_o, wb_cc_cfg_we_o, wb_reset0_we_o}),
    .wbs_cyc_o ({wb_flash0_cyc_o, wb_m2s_picorv32_ram0_cyc, wb_m2s_picorv32_hram0_cyc, wb_spi_conf_cyc_o, wb_gpio0_cyc_o, wb_uart0_cyc_o, wb_streamer_cyc_o, wb_sdc_slave_cyc_o, wb_cc_cfg_cyc_o, wb_reset0_cyc_o}),
    .wbs_stb_o ({wb_flash0_stb_o, wb_m2s_picorv32_ram0_stb, wb_m2s_picorv32_hram0_stb, wb_spi_conf_stb_o, wb_gpio0_stb_o, wb_uart0_stb_o, wb_streamer_stb_o, wb_sdc_slave_stb_o, wb_cc_cfg_stb_o, wb_reset0_stb_o}),
    .wbs_cti_o ({wb_flash0_cti_o, wb_m2s_picorv32_ram0_cti, wb_m2s_picorv32_hram0_cti, wb_spi_conf_cti_o, wb_gpio0_cti_o, wb_uart0_cti_o, wb_streamer_cti_o, wb_sdc_slave_cti_o, wb_cc_cfg_cti_o, wb_reset0_cti_o}),
    .wbs_bte_o ({wb_flash0_bte_o, wb_m2s_picorv32_ram0_bte, wb_m2s_picorv32_hram0_bte, wb_spi_conf_bte_o, wb_gpio0_bte_o, wb_uart0_bte_o, wb_streamer_bte_o, wb_sdc_slave_bte_o, wb_cc_cfg_bte_o, wb_reset0_bte_o}),
    .wbs_dat_i ({wb_flash0_dat_i, wb_s2m_picorv32_ram0_dat, wb_s2m_picorv32_hram0_dat, wb_spi_conf_dat_i, wb_gpio0_dat_i, wb_uart0_dat_i, wb_streamer_dat_i, wb_sdc_slave_dat_i, wb_cc_cfg_dat_i, wb_reset0_dat_i}),
    .wbs_ack_i ({wb_flash0_ack_i, wb_s2m_picorv32_ram0_ack, wb_s2m_picorv32_hram0_ack, wb_spi_conf_ack_i, wb_gpio0_ack_i, wb_uart0_ack_i, wb_streamer_ack_i, wb_sdc_slave_ack_i, wb_cc_cfg_ack_i, wb_reset0_ack_i}),
    .wbs_err_i ({wb_flash0_err_i, wb_s2m_picorv32_ram0_err, wb_s2m_picorv32_hram0_err, wb_spi_conf_err_i, wb_gpio0_err_i, wb_uart0_err_i, wb_streamer_err_i, wb_sdc_slave_err_i, wb_cc_cfg_err_i, wb_reset0_err_i}),
    .wbs_rty_i ({wb_flash0_rty_i, wb_s2m_picorv32_ram0_rty, wb_s2m_picorv32_hram0_rty, wb_spi_conf_rty_i, wb_gpio0_rty_i, wb_uart0_rty_i, wb_streamer_rty_i, wb_sdc_slave_rty_i, wb_cc_cfg_rty_i, wb_reset0_rty_i}));

wb_mux
  #(.num_slaves (2),
    .MATCH_ADDR ({32'h04000000, 32'h01000000}),
    .MATCH_MASK ({32'hffe00000, 32'hffffc000}))
 wb_mux_streamer_master
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i (wb_streamer_master_adr_i),
    .wbm_dat_i (wb_streamer_master_dat_i),
    .wbm_sel_i (wb_streamer_master_sel_i),
    .wbm_we_i  (wb_streamer_master_we_i),
    .wbm_cyc_i (wb_streamer_master_cyc_i),
    .wbm_stb_i (wb_streamer_master_stb_i),
    .wbm_cti_i (wb_streamer_master_cti_i),
    .wbm_bte_i (wb_streamer_master_bte_i),
    .wbm_dat_o (wb_streamer_master_dat_o),
    .wbm_ack_o (wb_streamer_master_ack_o),
    .wbm_err_o (wb_streamer_master_err_o),
    .wbm_rty_o (wb_streamer_master_rty_o),
    .wbs_adr_o ({wb_m2s_streamer_master_hram0_adr, wb_m2s_streamer_master_ram0_adr}),
    .wbs_dat_o ({wb_m2s_streamer_master_hram0_dat, wb_m2s_streamer_master_ram0_dat}),
    .wbs_sel_o ({wb_m2s_streamer_master_hram0_sel, wb_m2s_streamer_master_ram0_sel}),
    .wbs_we_o  ({wb_m2s_streamer_master_hram0_we, wb_m2s_streamer_master_ram0_we}),
    .wbs_cyc_o ({wb_m2s_streamer_master_hram0_cyc, wb_m2s_streamer_master_ram0_cyc}),
    .wbs_stb_o ({wb_m2s_streamer_master_hram0_stb, wb_m2s_streamer_master_ram0_stb}),
    .wbs_cti_o ({wb_m2s_streamer_master_hram0_cti, wb_m2s_streamer_master_ram0_cti}),
    .wbs_bte_o ({wb_m2s_streamer_master_hram0_bte, wb_m2s_streamer_master_ram0_bte}),
    .wbs_dat_i ({wb_s2m_streamer_master_hram0_dat, wb_s2m_streamer_master_ram0_dat}),
    .wbs_ack_i ({wb_s2m_streamer_master_hram0_ack, wb_s2m_streamer_master_ram0_ack}),
    .wbs_err_i ({wb_s2m_streamer_master_hram0_err, wb_s2m_streamer_master_ram0_err}),
    .wbs_rty_i ({wb_s2m_streamer_master_hram0_rty, wb_s2m_streamer_master_ram0_rty}));

wb_mux
  #(.num_slaves (2),
    .MATCH_ADDR ({32'h04000000, 32'h01000000}),
    .MATCH_MASK ({32'hffe00000, 32'hffffc000}))
 wb_mux_sdc_master
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i (wb_sdc_master_adr_i),
    .wbm_dat_i (wb_sdc_master_dat_i),
    .wbm_sel_i (wb_sdc_master_sel_i),
    .wbm_we_i  (wb_sdc_master_we_i),
    .wbm_cyc_i (wb_sdc_master_cyc_i),
    .wbm_stb_i (wb_sdc_master_stb_i),
    .wbm_cti_i (wb_sdc_master_cti_i),
    .wbm_bte_i (wb_sdc_master_bte_i),
    .wbm_dat_o (wb_sdc_master_dat_o),
    .wbm_ack_o (wb_sdc_master_ack_o),
    .wbm_err_o (wb_sdc_master_err_o),
    .wbm_rty_o (wb_sdc_master_rty_o),
    .wbs_adr_o ({wb_m2s_sdc_master_hram0_adr, wb_m2s_sdc_master_ram0_adr}),
    .wbs_dat_o ({wb_m2s_sdc_master_hram0_dat, wb_m2s_sdc_master_ram0_dat}),
    .wbs_sel_o ({wb_m2s_sdc_master_hram0_sel, wb_m2s_sdc_master_ram0_sel}),
    .wbs_we_o  ({wb_m2s_sdc_master_hram0_we, wb_m2s_sdc_master_ram0_we}),
    .wbs_cyc_o ({wb_m2s_sdc_master_hram0_cyc, wb_m2s_sdc_master_ram0_cyc}),
    .wbs_stb_o ({wb_m2s_sdc_master_hram0_stb, wb_m2s_sdc_master_ram0_stb}),
    .wbs_cti_o ({wb_m2s_sdc_master_hram0_cti, wb_m2s_sdc_master_ram0_cti}),
    .wbs_bte_o ({wb_m2s_sdc_master_hram0_bte, wb_m2s_sdc_master_ram0_bte}),
    .wbs_dat_i ({wb_s2m_sdc_master_hram0_dat, wb_s2m_sdc_master_ram0_dat}),
    .wbs_ack_i ({wb_s2m_sdc_master_hram0_ack, wb_s2m_sdc_master_ram0_ack}),
    .wbs_err_i ({wb_s2m_sdc_master_hram0_err, wb_s2m_sdc_master_ram0_err}),
    .wbs_rty_i ({wb_s2m_sdc_master_hram0_rty, wb_s2m_sdc_master_ram0_rty}));

wb_arbiter
  #(.num_masters (3))
 wb_arbiter_ram0
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i ({wb_m2s_picorv32_ram0_adr, wb_m2s_streamer_master_ram0_adr, wb_m2s_sdc_master_ram0_adr}),
    .wbm_dat_i ({wb_m2s_picorv32_ram0_dat, wb_m2s_streamer_master_ram0_dat, wb_m2s_sdc_master_ram0_dat}),
    .wbm_sel_i ({wb_m2s_picorv32_ram0_sel, wb_m2s_streamer_master_ram0_sel, wb_m2s_sdc_master_ram0_sel}),
    .wbm_we_i  ({wb_m2s_picorv32_ram0_we, wb_m2s_streamer_master_ram0_we, wb_m2s_sdc_master_ram0_we}),
    .wbm_cyc_i ({wb_m2s_picorv32_ram0_cyc, wb_m2s_streamer_master_ram0_cyc, wb_m2s_sdc_master_ram0_cyc}),
    .wbm_stb_i ({wb_m2s_picorv32_ram0_stb, wb_m2s_streamer_master_ram0_stb, wb_m2s_sdc_master_ram0_stb}),
    .wbm_cti_i ({wb_m2s_picorv32_ram0_cti, wb_m2s_streamer_master_ram0_cti, wb_m2s_sdc_master_ram0_cti}),
    .wbm_bte_i ({wb_m2s_picorv32_ram0_bte, wb_m2s_streamer_master_ram0_bte, wb_m2s_sdc_master_ram0_bte}),
    .wbm_dat_o ({wb_s2m_picorv32_ram0_dat, wb_s2m_streamer_master_ram0_dat, wb_s2m_sdc_master_ram0_dat}),
    .wbm_ack_o ({wb_s2m_picorv32_ram0_ack, wb_s2m_streamer_master_ram0_ack, wb_s2m_sdc_master_ram0_ack}),
    .wbm_err_o ({wb_s2m_picorv32_ram0_err, wb_s2m_streamer_master_ram0_err, wb_s2m_sdc_master_ram0_err}),
    .wbm_rty_o ({wb_s2m_picorv32_ram0_rty, wb_s2m_streamer_master_ram0_rty, wb_s2m_sdc_master_ram0_rty}),
    .wbs_adr_o (wb_ram0_adr_o),
    .wbs_dat_o (wb_ram0_dat_o),
    .wbs_sel_o (wb_ram0_sel_o),
    .wbs_we_o  (wb_ram0_we_o),
    .wbs_cyc_o (wb_ram0_cyc_o),
    .wbs_stb_o (wb_ram0_stb_o),
    .wbs_cti_o (wb_ram0_cti_o),
    .wbs_bte_o (wb_ram0_bte_o),
    .wbs_dat_i (wb_ram0_dat_i),
    .wbs_ack_i (wb_ram0_ack_i),
    .wbs_err_i (wb_ram0_err_i),
    .wbs_rty_i (wb_ram0_rty_i));

wb_arbiter
  #(.num_masters (3))
 wb_arbiter_hram0
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i ({wb_m2s_picorv32_hram0_adr, wb_m2s_streamer_master_hram0_adr, wb_m2s_sdc_master_hram0_adr}),
    .wbm_dat_i ({wb_m2s_picorv32_hram0_dat, wb_m2s_streamer_master_hram0_dat, wb_m2s_sdc_master_hram0_dat}),
    .wbm_sel_i ({wb_m2s_picorv32_hram0_sel, wb_m2s_streamer_master_hram0_sel, wb_m2s_sdc_master_hram0_sel}),
    .wbm_we_i  ({wb_m2s_picorv32_hram0_we, wb_m2s_streamer_master_hram0_we, wb_m2s_sdc_master_hram0_we}),
    .wbm_cyc_i ({wb_m2s_picorv32_hram0_cyc, wb_m2s_streamer_master_hram0_cyc, wb_m2s_sdc_master_hram0_cyc}),
    .wbm_stb_i ({wb_m2s_picorv32_hram0_stb, wb_m2s_streamer_master_hram0_stb, wb_m2s_sdc_master_hram0_stb}),
    .wbm_cti_i ({wb_m2s_picorv32_hram0_cti, wb_m2s_streamer_master_hram0_cti, wb_m2s_sdc_master_hram0_cti}),
    .wbm_bte_i ({wb_m2s_picorv32_hram0_bte, wb_m2s_streamer_master_hram0_bte, wb_m2s_sdc_master_hram0_bte}),
    .wbm_dat_o ({wb_s2m_picorv32_hram0_dat, wb_s2m_streamer_master_hram0_dat, wb_s2m_sdc_master_hram0_dat}),
    .wbm_ack_o ({wb_s2m_picorv32_hram0_ack, wb_s2m_streamer_master_hram0_ack, wb_s2m_sdc_master_hram0_ack}),
    .wbm_err_o ({wb_s2m_picorv32_hram0_err, wb_s2m_streamer_master_hram0_err, wb_s2m_sdc_master_hram0_err}),
    .wbm_rty_o ({wb_s2m_picorv32_hram0_rty, wb_s2m_streamer_master_hram0_rty, wb_s2m_sdc_master_hram0_rty}),
    .wbs_adr_o (wb_hram0_adr_o),
    .wbs_dat_o (wb_hram0_dat_o),
    .wbs_sel_o (wb_hram0_sel_o),
    .wbs_we_o  (wb_hram0_we_o),
    .wbs_cyc_o (wb_hram0_cyc_o),
    .wbs_stb_o (wb_hram0_stb_o),
    .wbs_cti_o (wb_hram0_cti_o),
    .wbs_bte_o (wb_hram0_bte_o),
    .wbs_dat_i (wb_hram0_dat_i),
    .wbs_ack_i (wb_hram0_ack_i),
    .wbs_err_i (wb_hram0_err_i),
    .wbs_rty_i (wb_hram0_rty_i));

endmodule
