///////////////////////////////////////////////////////////////////////////////////////////////////
//
// Copyright 2021 by Heqing Huang (feipenghhq@gamil.com)
//
// ~~~ Hardware in SpinalHDL ~~~
//
// Module Name: cpu_cfg
//
// Author: Heqing Huang
// Date Created: 03/27/2021
//
// ================== Description ==================
//
// Define basic parameters for the CPU
//
///////////////////////////////////////////////////////////////////////////////////////////////////

package core

import spinal.core._

case class cpu_cfg() {
    val DATA_WIDTH      = 32                // 32 bit cpu
    val PC_WIDTH        = DATA_WIDTH
    val RF_WIDTH        = DATA_WIDTH        // Register File width
    val RF_SIZE         = 32                // Register File size
    val RF_ADDR_WDITH   = log2Up(RF_SIZE)   // Register File address width
}

