;buildInfoPackage: chisel3, version: 3.3.1, scalaVersion: 2.12.11, sbtVersion: 1.3.10
circuit HanningWithFIFO : 
  module Hanning : 
    input clock : Clock
    input reset : Reset
    output io : {flip signal : {flip ready : UInt<1>, valid : UInt<1>, bits : {value : Fixed<32><<16>>}}, flip cosines : {flip ready : UInt<1>, valid : UInt<1>, bits : {value : Fixed<32><<16>>}}, HanningSignal : {flip ready : UInt<1>, valid : UInt<1>, bits : {value : Fixed<32><<16>>}}}
    
    cmem cosinesbank : {value : Fixed<32><<16>>}[720] @[Hanning.scala 20:28]
    reg cosinesbank_wcnt : UInt<32>, clock with : (reset => (reset, UInt<32>("h00"))) @[Hanning.scala 21:33]
    reg cosinesbank_rcnt : UInt<32>, clock with : (reset => (reset, UInt<32>("h00"))) @[Hanning.scala 22:33]
    node _T = and(io.cosines.valid, io.cosines.ready) @[Hanning.scala 23:25]
    when _T : @[Hanning.scala 23:45]
      node _T_1 = add(cosinesbank_wcnt, UInt<1>("h01")) @[Hanning.scala 24:42]
      node _T_2 = tail(_T_1, 1) @[Hanning.scala 24:42]
      cosinesbank_wcnt <= _T_2 @[Hanning.scala 24:22]
      node _T_3 = bits(cosinesbank_wcnt, 9, 0)
      write mport _T_4 = cosinesbank[_T_3], clock
      _T_4.value <= io.cosines.bits.value
      skip @[Hanning.scala 23:45]
    node _T_5 = lt(cosinesbank_wcnt, UInt<10>("h02d0")) @[Hanning.scala 27:61]
    node _T_6 = and(io.cosines.valid, _T_5) @[Hanning.scala 27:40]
    io.cosines.ready <= _T_6 @[Hanning.scala 27:20]
    reg state : UInt<2>, clock with : (reset => (reset, UInt<2>("h00"))) @[Hanning.scala 31:22]
    node _T_7 = eq(state, UInt<2>("h00")) @[Hanning.scala 33:14]
    when _T_7 : @[Hanning.scala 33:25]
      node _T_8 = and(io.signal.valid, io.signal.ready) @[Hanning.scala 34:26]
      node _T_9 = lt(cosinesbank_rcnt, UInt<9>("h0140")) @[Hanning.scala 34:64]
      node _T_10 = and(_T_8, _T_9) @[Hanning.scala 34:45]
      when _T_10 : @[Hanning.scala 34:71]
        state <= UInt<2>("h01") @[Hanning.scala 35:13]
        skip @[Hanning.scala 34:71]
      else : @[Hanning.scala 36:77]
        node _T_11 = and(io.signal.valid, io.signal.ready) @[Hanning.scala 36:32]
        node _T_12 = lt(cosinesbank_rcnt, UInt<10>("h0200")) @[Hanning.scala 36:70]
        node _T_13 = and(_T_11, _T_12) @[Hanning.scala 36:51]
        when _T_13 : @[Hanning.scala 36:77]
          state <= UInt<2>("h02") @[Hanning.scala 37:13]
          skip @[Hanning.scala 36:77]
      skip @[Hanning.scala 33:25]
    else : @[Hanning.scala 39:32]
      node _T_14 = eq(state, UInt<2>("h01")) @[Hanning.scala 39:20]
      when _T_14 : @[Hanning.scala 39:32]
        node _T_15 = and(io.signal.valid, io.signal.ready) @[Hanning.scala 40:26]
        node _T_16 = lt(cosinesbank_rcnt, UInt<9>("h0140")) @[Hanning.scala 40:64]
        node _T_17 = and(_T_15, _T_16) @[Hanning.scala 40:45]
        when _T_17 : @[Hanning.scala 40:71]
          state <= UInt<2>("h01") @[Hanning.scala 41:13]
          skip @[Hanning.scala 40:71]
        else : @[Hanning.scala 42:77]
          node _T_18 = and(io.signal.valid, io.signal.ready) @[Hanning.scala 42:32]
          node _T_19 = lt(cosinesbank_rcnt, UInt<10>("h0200")) @[Hanning.scala 42:70]
          node _T_20 = and(_T_18, _T_19) @[Hanning.scala 42:51]
          when _T_20 : @[Hanning.scala 42:77]
            state <= UInt<2>("h02") @[Hanning.scala 43:13]
            skip @[Hanning.scala 42:77]
          else : @[Hanning.scala 44:16]
            state <= UInt<2>("h00") @[Hanning.scala 45:13]
            skip @[Hanning.scala 44:16]
        skip @[Hanning.scala 39:32]
      else : @[Hanning.scala 47:37]
        node _T_21 = eq(state, UInt<2>("h02")) @[Hanning.scala 47:20]
        when _T_21 : @[Hanning.scala 47:37]
          node _T_22 = and(io.HanningSignal.ready, io.HanningSignal.valid) @[Hanning.scala 48:35]
          node _T_23 = lt(cosinesbank_rcnt, UInt<10>("h0200")) @[Hanning.scala 48:81]
          node _T_24 = and(_T_22, _T_23) @[Hanning.scala 48:61]
          when _T_24 : @[Hanning.scala 48:89]
            state <= UInt<2>("h02") @[Hanning.scala 49:15]
            skip @[Hanning.scala 48:89]
          else : @[Hanning.scala 50:18]
            state <= UInt<2>("h00") @[Hanning.scala 51:15]
            skip @[Hanning.scala 50:18]
          skip @[Hanning.scala 47:37]
    reg hanning_signal : {value : Fixed<32><<16>>}, clock @[Hanning.scala 55:27]
    reg cosine_value : {value : Fixed<32><<16>>}, clock @[Hanning.scala 56:27]
    io.HanningSignal.bits.value <= hanning_signal.value @[Hanning.scala 58:25]
    node _T_25 = eq(state, UInt<2>("h00")) @[Hanning.scala 60:14]
    when _T_25 : @[Hanning.scala 60:25]
      node _T_26 = and(io.HanningSignal.ready, io.signal.valid) @[Hanning.scala 61:47]
      io.signal.ready <= _T_26 @[Hanning.scala 61:21]
      io.HanningSignal.valid <= UInt<1>("h00") @[Hanning.scala 62:28]
      node _T_27 = bits(cosinesbank_rcnt, 9, 0) @[Hanning.scala 63:38]
      read mport _T_28 = cosinesbank[_T_27], clock @[Hanning.scala 63:38]
      cosine_value.value <= _T_28.value @[Hanning.scala 63:18]
      node _T_29 = eq(cosinesbank_rcnt, UInt<10>("h0201")) @[Hanning.scala 64:27]
      when _T_29 : @[Hanning.scala 64:37]
        cosinesbank_rcnt <= UInt<1>("h00") @[Hanning.scala 64:54]
        skip @[Hanning.scala 64:37]
      skip @[Hanning.scala 60:25]
    else : @[Hanning.scala 65:32]
      node _T_30 = eq(state, UInt<2>("h01")) @[Hanning.scala 65:20]
      when _T_30 : @[Hanning.scala 65:32]
        node _T_31 = add(cosinesbank_rcnt, UInt<1>("h01")) @[Hanning.scala 66:42]
        node _T_32 = tail(_T_31, 1) @[Hanning.scala 66:42]
        cosinesbank_rcnt <= _T_32 @[Hanning.scala 66:22]
        node _T_33 = bits(cosinesbank_rcnt, 9, 0) @[Hanning.scala 67:37]
        read mport _T_34 = cosinesbank[_T_33], clock @[Hanning.scala 67:37]
        cosine_value.value <= _T_34.value @[Hanning.scala 67:18]
        node _T_35 = mul(io.signal.bits.value, cosine_value.value) @[Hanning.scala 68:50]
        hanning_signal.value <= _T_35 @[Hanning.scala 68:26]
        io.signal.ready <= io.HanningSignal.ready @[Hanning.scala 69:21]
        io.HanningSignal.valid <= UInt<1>("h01") @[Hanning.scala 70:28]
        skip @[Hanning.scala 65:32]
      else : @[Hanning.scala 71:37]
        node _T_36 = eq(state, UInt<2>("h02")) @[Hanning.scala 71:20]
        when _T_36 : @[Hanning.scala 71:37]
          node _T_37 = add(cosinesbank_rcnt, UInt<1>("h01")) @[Hanning.scala 72:42]
          node _T_38 = tail(_T_37, 1) @[Hanning.scala 72:42]
          cosinesbank_rcnt <= _T_38 @[Hanning.scala 72:22]
          hanning_signal.value <= asFixedPoint(UInt<32>("h00"), 16) @[Hanning.scala 73:26]
          io.signal.ready <= UInt<1>("h00") @[Hanning.scala 74:21]
          io.HanningSignal.valid <= UInt<1>("h01") @[Hanning.scala 75:28]
          skip @[Hanning.scala 71:37]
        else : @[Hanning.scala 76:14]
          io.signal.ready <= UInt<1>("h01") @[Hanning.scala 77:21]
          io.HanningSignal.valid <= UInt<1>("h00") @[Hanning.scala 78:28]
          skip @[Hanning.scala 76:14]
    
  module MyFifo : 
    input clock : Clock
    input reset : Reset
    output io : {flip datain : {value : Fixed<32><<16>>}, dataout : {value : Fixed<32><<16>>}, flip wr : UInt<1>, flip rd : UInt<1>, full : UInt<1>, empty : UInt<1>, MorethanN : UInt<1>}
    
    reg count : UInt<32>, clock with : (reset => (reset, UInt<32>("h00"))) @[Myfifo.scala 23:22]
    cmem mem : {value : Fixed<32><<16>>}[3000] @[Myfifo.scala 24:16]
    reg wp : UInt<32>, clock with : (reset => (reset, UInt<32>("h00"))) @[Myfifo.scala 25:19]
    reg rp : UInt<32>, clock with : (reset => (reset, UInt<32>("h00"))) @[Myfifo.scala 26:19]
    reg dataout : {value : Fixed<32><<16>>}, clock @[Myfifo.scala 27:20]
    node _T = eq(io.wr, UInt<1>("h01")) @[Myfifo.scala 37:14]
    node _T_1 = eq(io.rd, UInt<1>("h01")) @[Myfifo.scala 37:34]
    node _T_2 = and(_T, _T_1) @[Myfifo.scala 37:25]
    when _T_2 : @[Myfifo.scala 37:46]
      node _T_3 = eq(count, UInt<1>("h00")) @[Myfifo.scala 38:16]
      when _T_3 : @[Myfifo.scala 38:25]
        io.dataout.value <= io.datain.value @[Myfifo.scala 38:38]
        skip @[Myfifo.scala 38:25]
      else : @[Myfifo.scala 39:18]
        node _T_4 = bits(rp, 11, 0) @[Myfifo.scala 40:26]
        infer mport _T_5 = mem[_T_4], clock @[Myfifo.scala 40:26]
        io.dataout.value <= _T_5.value @[Myfifo.scala 40:20]
        wire _T_6 : UInt
        _T_6 <= rp
        node _T_7 = eq(rp, UInt<12>("h0bb7")) @[Myfifo.scala 32:16]
        when _T_7 : @[Myfifo.scala 32:35]
          _T_6 <= UInt<1>("h00") @[Myfifo.scala 32:42]
          skip @[Myfifo.scala 32:35]
        else : @[Myfifo.scala 33:18]
          node _T_8 = add(rp, UInt<1>("h01")) @[Myfifo.scala 33:34]
          node _T_9 = tail(_T_8, 1) @[Myfifo.scala 33:34]
          _T_6 <= _T_9 @[Myfifo.scala 33:25]
          skip @[Myfifo.scala 33:18]
        rp <= _T_6 @[Myfifo.scala 41:12]
        node _T_10 = bits(wp, 11, 0) @[Myfifo.scala 42:12]
        infer mport _T_11 = mem[_T_10], clock @[Myfifo.scala 42:12]
        _T_11.value <= io.datain.value @[Myfifo.scala 42:17]
        wire _T_12 : UInt
        _T_12 <= wp
        node _T_13 = eq(wp, UInt<12>("h0bb7")) @[Myfifo.scala 32:16]
        when _T_13 : @[Myfifo.scala 32:35]
          _T_12 <= UInt<1>("h00") @[Myfifo.scala 32:42]
          skip @[Myfifo.scala 32:35]
        else : @[Myfifo.scala 33:18]
          node _T_14 = add(wp, UInt<1>("h01")) @[Myfifo.scala 33:34]
          node _T_15 = tail(_T_14, 1) @[Myfifo.scala 33:34]
          _T_12 <= _T_15 @[Myfifo.scala 33:25]
          skip @[Myfifo.scala 33:18]
        wp <= _T_12 @[Myfifo.scala 43:12]
        skip @[Myfifo.scala 39:18]
      skip @[Myfifo.scala 37:46]
    else : @[Myfifo.scala 45:55]
      node _T_16 = eq(io.wr, UInt<1>("h01")) @[Myfifo.scala 45:22]
      node _T_17 = eq(io.rd, UInt<1>("h00")) @[Myfifo.scala 45:42]
      node _T_18 = and(_T_16, _T_17) @[Myfifo.scala 45:33]
      when _T_18 : @[Myfifo.scala 45:55]
        io.dataout.value <= asFixedPoint(UInt<32>("h00"), 16) @[Myfifo.scala 46:22]
        node _T_19 = lt(count, UInt<12>("h0bb8")) @[Myfifo.scala 47:16]
        when _T_19 : @[Myfifo.scala 47:27]
          node _T_20 = bits(wp, 11, 0) @[Myfifo.scala 48:10]
          infer mport _T_21 = mem[_T_20], clock @[Myfifo.scala 48:10]
          _T_21.value <= io.datain.value @[Myfifo.scala 48:15]
          wire _T_22 : UInt
          _T_22 <= wp
          node _T_23 = eq(wp, UInt<12>("h0bb7")) @[Myfifo.scala 32:16]
          when _T_23 : @[Myfifo.scala 32:35]
            _T_22 <= UInt<1>("h00") @[Myfifo.scala 32:42]
            skip @[Myfifo.scala 32:35]
          else : @[Myfifo.scala 33:18]
            node _T_24 = add(wp, UInt<1>("h01")) @[Myfifo.scala 33:34]
            node _T_25 = tail(_T_24, 1) @[Myfifo.scala 33:34]
            _T_22 <= _T_25 @[Myfifo.scala 33:25]
            skip @[Myfifo.scala 33:18]
          wp <= _T_22 @[Myfifo.scala 49:10]
          node _T_26 = add(count, UInt<1>("h01")) @[Myfifo.scala 50:22]
          node _T_27 = tail(_T_26, 1) @[Myfifo.scala 50:22]
          count <= _T_27 @[Myfifo.scala 50:13]
          skip @[Myfifo.scala 47:27]
        skip @[Myfifo.scala 45:55]
      else : @[Myfifo.scala 52:55]
        node _T_28 = eq(io.wr, UInt<1>("h00")) @[Myfifo.scala 52:22]
        node _T_29 = eq(io.rd, UInt<1>("h01")) @[Myfifo.scala 52:43]
        node _T_30 = and(_T_28, _T_29) @[Myfifo.scala 52:34]
        when _T_30 : @[Myfifo.scala 52:55]
          node _T_31 = gt(count, UInt<1>("h00")) @[Myfifo.scala 53:16]
          when _T_31 : @[Myfifo.scala 53:23]
            node _T_32 = bits(rp, 11, 0) @[Myfifo.scala 54:24]
            infer mport _T_33 = mem[_T_32], clock @[Myfifo.scala 54:24]
            io.dataout.value <= _T_33.value @[Myfifo.scala 54:18]
            wire _T_34 : UInt
            _T_34 <= rp
            node _T_35 = eq(rp, UInt<12>("h0bb7")) @[Myfifo.scala 32:16]
            when _T_35 : @[Myfifo.scala 32:35]
              _T_34 <= UInt<1>("h00") @[Myfifo.scala 32:42]
              skip @[Myfifo.scala 32:35]
            else : @[Myfifo.scala 33:18]
              node _T_36 = add(rp, UInt<1>("h01")) @[Myfifo.scala 33:34]
              node _T_37 = tail(_T_36, 1) @[Myfifo.scala 33:34]
              _T_34 <= _T_37 @[Myfifo.scala 33:25]
              skip @[Myfifo.scala 33:18]
            rp <= _T_34 @[Myfifo.scala 55:10]
            node _T_38 = sub(count, UInt<1>("h01")) @[Myfifo.scala 56:22]
            node _T_39 = tail(_T_38, 1) @[Myfifo.scala 56:22]
            count <= _T_39 @[Myfifo.scala 56:13]
            skip @[Myfifo.scala 53:23]
          else : @[Myfifo.scala 57:18]
            io.dataout.value <= asFixedPoint(UInt<32>("h00"), 16) @[Myfifo.scala 58:24]
            skip @[Myfifo.scala 57:18]
          skip @[Myfifo.scala 52:55]
        else : @[Myfifo.scala 60:16]
          io.dataout.value <= asFixedPoint(UInt<32>("h00"), 16) @[Myfifo.scala 61:22]
          skip @[Myfifo.scala 60:16]
    node _T_40 = eq(UInt<12>("h0bb8"), count) @[Myfifo.scala 64:23]
    io.full <= _T_40 @[Myfifo.scala 64:11]
    node _T_41 = eq(count, UInt<1>("h00")) @[Myfifo.scala 65:22]
    io.empty <= _T_41 @[Myfifo.scala 65:12]
    node _T_42 = gt(count, UInt<10>("h0200")) @[Myfifo.scala 66:26]
    io.MorethanN <= _T_42 @[Myfifo.scala 66:16]
    
  module HanningWithFIFO : 
    input clock : Clock
    input reset : UInt<1>
    output io : {flip signal : {flip ready : UInt<1>, valid : UInt<1>, bits : {value : Fixed<32><<16>>}}, flip cosines : {flip ready : UInt<1>, valid : UInt<1>, bits : {value : Fixed<32><<16>>}}, HanningSignal : {flip ready : UInt<1>, valid : UInt<1>, bits : {value : Fixed<32><<16>>}}}
    
    inst Hanningblock of Hanning @[HanningWithFIFO.scala 18:37]
    Hanningblock.clock <= clock
    Hanningblock.reset <= reset
    inst HanningFIFO of MyFifo @[HanningWithFIFO.scala 19:35]
    HanningFIFO.clock <= clock
    HanningFIFO.reset <= reset
    reg BurstValid : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[HanningWithFIFO.scala 20:27]
    reg BurstReadCnt : UInt<32>, clock with : (reset => (reset, UInt<32>("h00"))) @[HanningWithFIFO.scala 21:29]
    wire BurstTransEn : UInt<1> @[HanningWithFIFO.scala 22:26]
    node _T = lt(BurstReadCnt, UInt<10>("h0200")) @[HanningWithFIFO.scala 23:47]
    node _T_1 = gt(BurstReadCnt, UInt<1>("h00")) @[HanningWithFIFO.scala 23:71]
    node _T_2 = and(_T, _T_1) @[HanningWithFIFO.scala 23:55]
    node _T_3 = or(BurstValid, _T_2) @[HanningWithFIFO.scala 23:31]
    BurstTransEn <= _T_3 @[HanningWithFIFO.scala 23:16]
    node _T_4 = and(io.HanningSignal.ready, BurstValid) @[HanningWithFIFO.scala 25:31]
    when _T_4 : @[HanningWithFIFO.scala 25:45]
      node _T_5 = add(BurstReadCnt, UInt<1>("h01")) @[HanningWithFIFO.scala 26:34]
      node _T_6 = tail(_T_5, 1) @[HanningWithFIFO.scala 26:34]
      BurstReadCnt <= _T_6 @[HanningWithFIFO.scala 26:18]
      BurstValid <= UInt<1>("h00") @[HanningWithFIFO.scala 27:16]
      skip @[HanningWithFIFO.scala 25:45]
    else : @[HanningWithFIFO.scala 28:27]
      when BurstTransEn : @[HanningWithFIFO.scala 28:27]
        node _T_7 = add(BurstReadCnt, UInt<1>("h01")) @[HanningWithFIFO.scala 29:34]
        node _T_8 = tail(_T_7, 1) @[HanningWithFIFO.scala 29:34]
        BurstReadCnt <= _T_8 @[HanningWithFIFO.scala 29:18]
        skip @[HanningWithFIFO.scala 28:27]
      else : @[HanningWithFIFO.scala 30:14]
        BurstReadCnt <= UInt<1>("h00") @[HanningWithFIFO.scala 31:18]
        when HanningFIFO.io.MorethanN : @[HanningWithFIFO.scala 32:35]
          BurstValid <= UInt<1>("h01") @[HanningWithFIFO.scala 32:48]
          skip @[HanningWithFIFO.scala 32:35]
        skip @[HanningWithFIFO.scala 30:14]
    Hanningblock.io.signal.bits.value <= io.signal.bits.value @[HanningWithFIFO.scala 35:26]
    Hanningblock.io.signal.valid <= io.signal.valid @[HanningWithFIFO.scala 35:26]
    io.signal.ready <= Hanningblock.io.signal.ready @[HanningWithFIFO.scala 35:26]
    Hanningblock.io.cosines.bits.value <= io.cosines.bits.value @[HanningWithFIFO.scala 36:27]
    Hanningblock.io.cosines.valid <= io.cosines.valid @[HanningWithFIFO.scala 36:27]
    io.cosines.ready <= Hanningblock.io.cosines.ready @[HanningWithFIFO.scala 36:27]
    io.HanningSignal.valid <= BurstValid @[HanningWithFIFO.scala 38:26]
    io.HanningSignal.bits.value <= HanningFIFO.io.dataout.value @[HanningWithFIFO.scala 39:26]
    HanningFIFO.io.datain.value <= Hanningblock.io.HanningSignal.bits.value @[HanningWithFIFO.scala 42:25]
    HanningFIFO.io.wr <= Hanningblock.io.HanningSignal.valid @[HanningWithFIFO.scala 43:21]
    node _T_9 = eq(HanningFIFO.io.full, UInt<1>("h00")) @[HanningWithFIFO.scala 44:42]
    Hanningblock.io.HanningSignal.ready <= _T_9 @[HanningWithFIFO.scala 44:39]
    node _T_10 = neq(BurstReadCnt, UInt<1>("h00")) @[HanningWithFIFO.scala 46:37]
    node _T_11 = and(_T_10, io.HanningSignal.ready) @[HanningWithFIFO.scala 46:45]
    HanningFIFO.io.rd <= _T_11 @[HanningWithFIFO.scala 46:21]
    
