contract Contract {
    function main() {
        memory[0x40:0x60] = 0x80;
    
        if (msg.data.length < 0x04) { stop(); }
        else {
            var var0 = msg.data[0x00:0x20] / 0x02 ** 0xe0 & 0xffffffff;
        
            if (var0 == 0x2810e1d6) {
                var var1 = msg.value;
            
                if (var1) { revert(memory[0x00:0x00]); }
            
                var1 = 0x00cc;
                // Method call to func_0277
                stop();
            } else if (0x4e7407ea == var0) {
                var1 = msg.value;
            
                if (var1) { revert(memory[0x00:0x00]); }
            
                var1 = 0x00cc;
                // Method call to func_0311
                stop();
            } else if (0x55aa91fc == var0) {
                var1 = msg.value;
            
                if (var1) { revert(memory[0x00:0x00]); }
            
                var1 = 0x0110;
                var var2 = msg.data[0x04:0x24];
                // Method call to func_034C
            
            label_0110:
                var temp0 = memory[0x40:0x60];
                memory[temp0:temp0 + 0x20] = var2 & 0x02 ** 0xa0 - 0x01;
                var temp1 = memory[0x40:0x60];
                return memory[temp1:temp1 + 0x20 + (temp0 - temp1)];
            } else if (0x5df81330 == var0) {
                var1 = msg.value;
            
                if (var1) { revert(memory[0x00:0x00]); }
            
                var1 = 0x0144;
                var2 = msg.data[0x04:0x24];
                // Method call to func_0374
            
            label_0144:
                var temp2 = memory[0x40:0x60];
                memory[temp2:temp2 + 0x20] = !!var2;
                var temp3 = memory[0x40:0x60];
                return memory[temp3:temp3 + 0x20 + (temp2 - temp3)];
            } else if (0x8d17afee == var0) {
                var1 = msg.value;
            
                if (var1) { revert(memory[0x00:0x00]); }
            
                var1 = 0x0110;
                // Method call to func_03A6
                goto label_0110;
            } else if (0x94d9c9c7 == var0) {
                var1 = msg.value;
            
                if (var1) { revert(memory[0x00:0x00]); }
            
                var1 = 0x00cc;
                var2 = msg.data[0x04:0x24] & 0x02 ** 0xa0 - 0x01;
                // Method call to func_03B5
                stop();
            } else if (0x9f21c1f2 == var0) {
                var1 = msg.value;
            
                if (var1) { revert(memory[0x00:0x00]); }
            
                var1 = 0x0110;
                // Method call to func_0479
                goto label_0110;
            } else if (0xa23e3474 == var0) {
                var1 = msg.value;
            
                if (var1) { revert(memory[0x00:0x00]); }
            
                var1 = 0x01b8;
                // Method call to func_0488
            
            label_01B8:
                var temp4 = memory[0x40:0x60];
                memory[temp4:temp4 + 0x20] = var2;
                var temp5 = memory[0x40:0x60];
                return memory[temp5:temp5 + 0x20 + (temp4 - temp5)];
            } else if (0xa97b3497 == var0) {
                var1 = msg.value;
            
                if (var1) { revert(memory[0x00:0x00]); }
            
                var1 = 0x0110;
                // Method call to func_048E
                goto label_0110;
            } else if (0xb81f39a8 == var0) {
                var1 = 0x01b8;
                // Method call to func_049D
                goto label_01B8;
            } else if (0xd0b06f5d == var0) {
                var1 = msg.value;
            
                if (var1) { revert(memory[0x00:0x00]); }
            
                var1 = 0x01b8;
                // Method call to func_0553
                goto label_01B8;
            } else if (0xd6b142b2 == var0) {
                var1 = msg.value;
            
                if (var1) { revert(memory[0x00:0x00]); }
            
                var1 = 0x01b8;
                // Method call to func_0559
                goto label_01B8;
            } else if (0xd8e7d36a == var0) {
                var1 = msg.value;
            
                if (var1) { revert(memory[0x00:0x00]); }
            
                var1 = 0x0110;
                var2 = msg.data[0x04:0x24];
                // Method call to func_055F
                goto label_0110;
            } else if (0xe07fa3c1 == var0) {
                var1 = msg.value;
            
                if (var1) { revert(memory[0x00:0x00]); }
            
                var1 = 0x0144;
                // Method call to func_056D
                goto label_0144;
            } else if (0xe2179b8e == var0) {
                var1 = msg.value;
            
                if (var1) { revert(memory[0x00:0x00]); }
            
                var1 = 0x0110;
                // Method call to func_0711
                goto label_0110;
            } else {
                if (0xf494b585 != var0) { stop(); }
            
                var1 = msg.value;
            
                if (var1) { revert(memory[0x00:0x00]); }
            
                var1 = 0x00cc;
                var2 = msg.data[0x04:0x24];
                var var3 = msg.data[0x24:0x44] & 0x02 ** 0xa0 - 0x01;
                // Method call to func_0720
                stop();
            }
        }
    }
    
    function func_0277() {
        if (msg.sender != 0x02 ** 0xa0 - 0x01 & storage[0x0a]) { revert(memory[0x00:0x00]); }
    
        var temp0 = memory[0x40:0x60];
        memory[temp0:temp0 + 0x20] = 0x7265736f6c766528290000000000000000000000000000000000000000000000;
        var temp1 = memory[0x40:0x60];
        var temp2 = memory[0x40:0x60];
        memory[temp2:temp2 + 0x20] = 0x02 ** 0xe0 * (0xffffffff & keccak256(memory[temp1:temp1 + (0x09 + temp0) - temp1]) / 0x02 ** 0xe0);
        var temp3 = memory[0x40:0x60];
        memory[temp3:temp3 + 0x00] = address(0x02 ** 0xa0 - 0x01 & 0x02 ** 0xa0 - 0x01 & storage[0x0b] / 0x0100 ** 0x00).delegatecall.gas(msg.gas)(memory[temp3:temp3 + (0x04 + temp2) - temp3]);
        // Could not resolve jump destination (is this a return?)
    }
    
    function func_0311() {
        if (0x02 ** 0xa0 - 0x01 & storage[0x0a]) { revert(memory[0x00:0x00]); }
    
        storage[0x06] = block.timestamp;
        storage[0x0a] = msg.sender | (~0xffffffffffffffffffffffffffffffffffffffff & storage[0x0a]);
        // Could not resolve jump destination (is this a return?)
    }
    
    function func_034C() {
        var var0 = 0x08;
        var var1 = arg0;
    
        if (var1 >= storage[var0]) { assert(); }
    
        memory[0x00:0x20] = var0;
        arg0 = 0x02 ** 0xa0 - 0x01 & storage[keccak256(memory[0x00:0x20]) + var1];
        // Could not resolve jump destination (is this a return?)
    }
    
    function func_0374() {
        var var0 = 0x07;
        var var1 = arg0;
    
        if (var1 >= storage[var0]) { assert(); }
    
        var temp0 = var1;
        memory[0x00:0x20] = var0;
        arg0 = 0xff & storage[temp0 / 0x20 + keccak256(memory[0x00:0x20])] / 0x0100 ** (temp0 % 0x20);
        // Could not resolve jump destination (is this a return?)
    }
    
    function func_03A6() {
        var var0 = 0x02 ** 0xa0 - 0x01 & storage[0x04];
        // Could not resolve jump destination (is this a return?)
    }
    
    function func_03B5() {
        var var0 = 0x00;
        var var1 = var0;
    
        if (var1 >= storage[0x08]) {
        label_0404:
        
            if (var0) {
                // Could not resolve jump destination (is this a return?)
            } else {
                var temp0 = arg0 & 0x02 ** 0xa0 - 0x01;
                var temp1 = ~0xffffffffffffffffffffffffffffffffffffffff;
                storage[0x03] = temp0 | (temp1 & storage[0x03]);
                var temp2 = storage[0x08];
                storage[0x08] = temp2 + 0x01;
                memory[0x00:0x20] = 0x08;
                var temp3 = 0xf3f7a9fe364faab93b216da50a3214154f22a0a2b415b23a84c8169e8b636ee3 + temp2;
                storage[temp3] = temp0 | (temp1 & storage[temp3]);
                // Could not resolve jump destination (is this a return?)
            }
        } else {
        label_03C4:
            var var2 = 0x02 ** 0xa0 - 0x01 & arg0;
            var var3 = 0x08;
            var var4 = var1;
        
            if (var4 >= storage[var3]) { assert(); }
        
            memory[0x00:0x20] = var3;
        
            if (0x02 ** 0xa0 - 0x01 & storage[keccak256(memory[0x00:0x20]) + var4] != var2) {
                var1 = 0x01 + var1;
            
            label_03B9:
            
                if (var1 >= storage[0x08]) { goto label_0404; }
                else { goto label_03C4; }
            } else {
                var0 = 0x01;
                var1 = 0x01 + var1;
                goto label_03B9;
            }
        }
    }
    
    function func_0479() {
        var var0 = 0x02 ** 0xa0 - 0x01 & storage[0x03];
        // Could not resolve jump destination (is this a return?)
    }
    
    function func_0488() {
        var var0 = storage[0x01];
        // Could not resolve jump destination (is this a return?)
    }
    
    function func_048E() {
        var var0 = 0x02 ** 0xa0 - 0x01 & storage[0x05];
        // Could not resolve jump destination (is this a return?)
    }
    
    function func_049D() {
        storage[0x06] = block.timestamp;
        var temp0 = memory[0x40:0x60];
        memory[temp0:temp0 + 0x20] = 0x66077c0100000000000000000000000000000000000000000000000000000000;
        memory[temp0 + 0x04:temp0 + 0x04 + 0x20] = msg.sender;
        var temp1 = memory[0x40:0x60];
        var var0 = 0x00;
        var temp2 = 0x02 ** 0xa0 - 0x01 & storage[0x09];
        var var1 = temp2;
        var var2 = 0x66077c01;
        var var3 = temp0 + 0x24;
        var var4 = 0x20;
        var var5 = temp1;
        var var6 = temp0 - var5 + 0x24;
        var var7 = var5;
        var var8 = var0;
        var var9 = var1;
        var var10 = !address(var9).code.length;
    
        if (var10) { revert(memory[0x00:0x00]); }
    
        memory[var5:var5 + var4] = address(var9).call.gas(msg.gas).value(var8)(memory[var7:var7 + var6]);
        var4 = !address(var9).call.gas(msg.gas).value(var8)(memory[var7:var7 + var6]);
    
        if (!var4) {
            var1 = memory[0x40:0x60];
            var2 = returndata.length;
        
            if (var2 < 0x20) { revert(memory[0x00:0x00]); }
        
            if (!memory[var1:var1 + 0x20]) { revert(memory[0x00:0x00]); }
        
            if (msg.value <= 0x2386f26fc10000) { assert(); }
        
            arg0 = address(address(this)).balance;
            // Could not resolve jump destination (is this a return?)
        } else {
            var temp3 = returndata.length;
            memory[0x00:0x00 + temp3] = returndata[0x00:0x00 + temp3];
            revert(memory[0x00:0x00 + returndata.length]);
        }
    }
    
    function func_0553() {
        var var0 = storage[0x06];
        // Could not resolve jump destination (is this a return?)
    }
    
    function func_0559() {
        var var0 = storage[0x00];
        // Could not resolve jump destination (is this a return?)
    }
    
    function func_055F() {
        var var0 = 0x02;
        var var1 = arg0;
    
        if (var1 >= storage[var0]) { assert(); }
    
        memory[0x00:0x20] = var0;
        arg0 = 0x02 ** 0xa0 - 0x01 & storage[keccak256(memory[0x00:0x20]) + var1];
        // Could not resolve jump destination (is this a return?)
    }
    
    function func_056D() {
        var var0 = 0x00;
        var var1 = var0;
        var var2 = var1;
    
        if (msg.sender != 0x02 ** 0xa0 - 0x01 & storage[0x04]) {
            var2 = 0x00;
        
            if (var2 >= storage[0x02]) {
            label_05D7:
            
                if (!var1) { revert(memory[0x00:0x00]); }
            
                if (block.timestamp <= storage[0x00]) { revert(memory[0x00:0x00]); }
            
                var temp0 = memory[0x40:0x60];
                memory[temp0:temp0 + 0x20] = 0x6f62736572766528290000000000000000000000000000000000000000000000;
                var temp1 = memory[0x40:0x60];
                var temp2 = memory[0x40:0x60];
                memory[temp2:temp2 + 0x20] = 0x02 ** 0xe0 * (0xffffffff & keccak256(memory[temp1:temp1 + (0x09 + temp0) - temp1]) / 0x02 ** 0xe0);
                var temp3 = memory[0x40:0x60];
                memory[temp3:temp3 + 0x00] = address(0x02 ** 0xa0 - 0x01 & 0x02 ** 0xa0 - 0x01 & storage[0x03] / 0x0100 ** 0x00).call.gas(msg.gas).value(0x00)(memory[temp3:temp3 + (0x04 + temp2) - temp3]);
            
                if (!address(0x02 ** 0xa0 - 0x01 & 0x02 ** 0xa0 - 0x01 & storage[0x03] / 0x0100 ** 0x00).call.gas(msg.gas).value(0x00)(memory[temp3:temp3 + (0x04 + temp2) - temp3])) { assert(); }
            
                var temp4 = memory[0x40:0x60];
                memory[temp4:temp4 + 0x20] = 0x6261736963576974686472617728290000000000000000000000000000000000;
                var temp5 = memory[0x40:0x60];
                var temp6 = memory[0x40:0x60];
                memory[temp6:temp6 + 0x20] = 0x02 ** 0xe0 * (0xffffffff & keccak256(memory[temp5:temp5 + (0x0f + temp4) - temp5]) / 0x02 ** 0xe0);
                var temp7 = memory[0x40:0x60];
                memory[temp7:temp7 + 0x00] = address(0x02 ** 0xa0 - 0x01 & 0x02 ** 0xa0 - 0x01 & storage[0x0b] / 0x0100 ** 0x00).delegatecall.gas(msg.gas)(memory[temp7:temp7 + (0x04 + temp6) - temp7]);
                storage[0x00] = storage[0x01] + storage[0x00];
                arg0 = 0x01;
                // Could not resolve jump destination (is this a return?)
            } else {
            label_059B:
                var var3 = msg.sender;
                var var4 = 0x02;
                var var5 = var2;
            
                if (var5 >= storage[var4]) { assert(); }
            
                memory[0x00:0x20] = var4;
            
                if (0x02 ** 0xa0 - 0x01 & storage[keccak256(memory[0x00:0x20]) + var5] != var3) {
                    var2 = 0x01 + var2;
                
                    if (var2 >= storage[0x02]) { goto label_05D7; }
                    else { goto label_059B; }
                } else {
                    var1 = 0x01;
                    goto label_05D7;
                }
            }
        } else {
            var1 = 0x01;
            var2 = 0x00;
        
            if (var2 >= storage[0x02]) { goto label_05D7; }
            else { goto label_059B; }
        }
    }
    
    function func_0711() {
        var var0 = 0x02 ** 0xa0 - 0x01 & storage[0x09];
        // Could not resolve jump destination (is this a return?)
    }
    
    function func_0720() {
        var var0 = 0x00;
        var var1 = var0;
    
        if (msg.sender != 0x02 ** 0xa0 - 0x01 & storage[0x04]) {
            var1 = 0x00;
        
            if (var1 >= storage[0x02]) {
            label_0788:
            
                if (!var0) { revert(memory[0x00:0x00]); }
            
                if (arg1 >= storage[0x02]) { revert(memory[0x00:0x00]); }
            
                var var2 = 0x02;
                var var3 = arg1;
            
                if (var3 >= storage[var2]) { assert(); }
            
                memory[0x00:0x20] = var2;
            
                if (msg.sender != 0x02 ** 0xa0 - 0x01 & storage[keccak256(memory[0x00:0x20]) + var3]) { revert(memory[0x00:0x00]); }
            
                if (storage[0x05] & 0x02 ** 0xa0 - 0x01 == 0x02 ** 0xa0 - 0x01 & arg0) {
                label_0816:
                    var2 = 0x01;
                    var3 = 0x07;
                    var var4 = arg1;
                
                    if (var4 >= storage[var3]) { assert(); }
                
                    var temp0 = var4;
                    memory[0x00:0x20] = var3;
                    var temp1 = temp0 / 0x20 + keccak256(memory[0x00:0x20]);
                    var temp2 = 0x0100 ** (temp0 % 0x20);
                    storage[temp1] = !!var2 * temp2 | (~(0xff * temp2) & storage[temp1]);
                    var2 = 0x0858;
                    // Method call to func_08F1
                
                    if (!var2) {
                    label_0894:
                        // Could not resolve jump destination (is this a return?)
                    } else {
                        storage[0x04] = (storage[0x05] & 0x02 ** 0xa0 - 0x01) | (~0xffffffffffffffffffffffffffffffffffffffff & storage[0x04]);
                        var2 = 0x0894;
                        // Method call to func_089A
                        goto label_0894;
                    }
                } else {
                    var2 = 0x07ed;
                    // Method call to func_089A
                    storage[0x05] = (arg0 & 0x02 ** 0xa0 - 0x01) | (~0xffffffffffffffffffffffffffffffffffffffff & storage[0x05]);
                    goto label_0816;
                }
            } else {
            label_074C:
                var2 = msg.sender;
                var3 = 0x02;
                var4 = var1;
            
                if (var4 >= storage[var3]) { assert(); }
            
                memory[0x00:0x20] = var3;
            
                if (0x02 ** 0xa0 - 0x01 & storage[keccak256(memory[0x00:0x20]) + var4] != var2) {
                    var1 = 0x01 + var1;
                
                    if (var1 >= storage[0x02]) { goto label_0788; }
                    else { goto label_074C; }
                } else {
                    var0 = 0x01;
                    goto label_0788;
                }
            }
        } else {
            var0 = 0x01;
            var1 = 0x00;
        
            if (var1 >= storage[0x02]) { goto label_0788; }
            else { goto label_074C; }
        }
    }
    
    function func_089A() {
        var var0 = 0x00;
    
        if (var0 >= storage[0x07]) {
        label_08EE:
            // Could not resolve jump destination (is this a return?)
        } else {
        label_08A8:
            var var1 = 0x00;
            var var2 = 0x07;
            var var3 = var0;
        
            if (var3 >= storage[var2]) { assert(); }
        
            var temp0 = var3;
            memory[0x00:0x20] = var2;
            var temp1 = temp0 / 0x20 + keccak256(memory[0x00:0x20]);
            var temp2 = 0x0100 ** (temp0 % 0x20);
            storage[temp1] = !!var1 * temp2 | (~(0xff * temp2) & storage[temp1]);
            var0 = 0x01 + var0;
        
            if (var0 >= storage[0x07]) { goto label_08EE; }
            else { goto label_08A8; }
        }
    }
    
    function func_08F1() {
        var var0 = 0x00;
        var var1 = var0;
    
        if (var1 >= storage[0x07]) {
        label_0944:
            arg0 = 0x01;
            // Could not resolve jump destination (is this a return?)
        } else {
        label_0900:
            var var2 = 0x07;
            var var3 = var1;
        
            if (var3 >= storage[var2]) { assert(); }
        
            memory[0x00:0x20] = var2;
        
            if (0xff & storage[var3 / 0x20 + keccak256(memory[0x00:0x20])] / 0x0100 ** (var3 % 0x20)) {
                var1 = 0x01 + var1;
            
                if (var1 >= storage[0x07]) { goto label_0944; }
                else { goto label_0900; }
            } else {
                var0 = 0x00;
                arg0 = var0;
                // Could not resolve jump destination (is this a return?)
            }
        }
    }
}