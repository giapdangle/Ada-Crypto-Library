with AUnit.Assertions; 
with Ada.Text_IO;
with Crypto.Symmetric.MAC.HMAC_SHA512;
with Crypto.Types;

package body Test.SHA512_MAC is
   use Crypto.Types;
   
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
-------------------------------- Type - Declaration --------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
	
	package DIO is new Ada.Text_IO.Modular_IO (DWord);
	use DIO;
	
    Key1: DW_Block1024 := (0 => 16#0b_0b_0b_0b_0b_0b_0b_0b#,
                           1 => 16#0b_0b_0b_0b_0b_0b_0b_0b#,
                           2 => 16#0b_0b_0b_0b_00_00_00_00#,
                           others  => 0);
    
    
    Message1: DW_Block1024 := (0 => 16#48_69_20_54_68_65_72_65#,
                               others => 0);

    Key2:  DW_Block1024 := (0 => 16#4a_65_66_65_00_00_00_00#, others  => 0);
   
    Message2: DW_Block1024 := (0 => 16#77_68_61_74_20_64_6f_20#,
                               1 => 16#79_61_20_77_61_6e_74_20#,
                               2 => 16#66_6f_72_20_6e_6f_74_68#,
                               3 => 16#69_6e_67_3f_00_00_00_00#,
                               others  => 0);
    
    Key3: DW_Block1024 := (0 => 16#Aa_Aa_Aa_Aa_Aa_Aa_Aa_Aa#,
                           1 => 16#Aa_Aa_Aa_Aa_Aa_Aa_Aa_Aa#,
                           2 => 16#Aa_Aa_Aa_Aa_00_00_00_00#,
                           others => 0);
    
    Message3: DW_Block1024 := (0..5 => 16#Dd_Dd_Dd_Dd_Dd_Dd_Dd_Dd#,
                               6 =>    16#Dd_Dd_00_00_00_00_00_00#,
                               others => 0);
    
    Temp: DW_Block512 := (16#87_Aa_7c_De_A5_Ef_61_9d#,
                          16#4f_F0_B4_24_1a_1d_6c_B0#,
                          16#23_79_F4_E2_Ce_4e_C2_78#,
                          16#7a_D0_B3_05_45_E1_7c_De#,
                          16#Da_A8_33_B7_D6_B8_A7_02#,
                          16#03_8b_27_4e_Ae_A3_F4_E4#,
                          16#Be_9d_91_4e_Eb_61_F1_70#,
                          16#2e_69_6c_20_3a_12_68_54#);
    
    Tag: DW_Block512;

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
---------------------------- Register SHA512 MAC Test 1 ----------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
	
	procedure Register_Tests(T : in out HMAC_Test) is
		use Test_Cases.Registration;
	begin
		Register_Routine(T, SHA512_MAC_Test1'Access,"SHA512_MAC_Test1.");
		Register_Routine(T, SHA512_MAC_Test2'Access,"SHA512_MAC_Test2.");
		Register_Routine(T, SHA512_MAC_Test3'Access,"SHA512_MAC_Test3.");
	end Register_Tests;

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------- Name SHA512 MAC Test -------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

	function Name(T : HMAC_Test) return Test_String is
	begin
		return new String'("SHA512 MAC Test");
	end Name;

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------ Start Tests -----------------------------------
------------------------------------------------------------------------------------
-------------------------------------- Test 1 --------------------------------------
------------------------------------------------------------------------------------

   procedure SHA512_MAC_Test1(T : in out Test_Cases.Test_Case'Class) is
      use AUnit.Assertions; 
      use Crypto.Symmetric.MAC.HMAC_SHA512;

      Context : HMAC_Context;
      
   begin

   	   Context.Init(Key1);
   	   Context.Final_Sign(Message1, 8, Tag);

       Assert((Tag = Temp) or (Context.Final_Verify(Message1, 8, Tag)), "Final Signature with SHA512 MAC failed.");

   end SHA512_MAC_Test1;

------------------------------------------------------------------------------------
-------------------------------------- Test 2 --------------------------------------
------------------------------------------------------------------------------------

   procedure SHA512_MAC_Test2(T : in out Test_Cases.Test_Case'Class) is
      use AUnit.Assertions; 
      use Crypto.Symmetric.MAC.HMAC_SHA512;

      Context : HMAC_Context;
      
   begin
   	   
   	   Temp := (16#16_4b_7a_7b_Fc_F8_19_E2#, 16#E3_95_Fb_E7_3b_56_E0_A3#,
                16#87_Bd_64_22_2e_83_1f_D6#, 16#10_27_0c_D7_Ea_25_05_54#,
                16#97_58_Bf_75_C0_5a_99_4a#, 16#6d_03_4f_65_F8_F0_E6_Fd#,
                16#Ca_Ea_B1_A3_4d_4a_6b_4b#, 16#63_6e_07_0a_38_Bc_E7_37#);

   	   Context.Init(Key2);
   	   Context.Final_Sign(Message2, 28, Tag);

       Assert((Tag = Temp) or (Context.Final_Verify(Message2, 28, Tag)), "Final Signature with SHA512 MAC failed.");

   end SHA512_MAC_Test2;
------------------------------------------------------------------------------------
-------------------------------------- Test 3 --------------------------------------
------------------------------------------------------------------------------------

   procedure SHA512_MAC_Test3(T : in out Test_Cases.Test_Case'Class) is
      use AUnit.Assertions; 
      use Crypto.Symmetric.MAC.HMAC_SHA512;
      
      Context : HMAC_Context;

   begin
   	   
   	   Temp := (16#Fa_73_B0_08_9d_56_A2_84#, 16#Ef_B0_F0_75_6c_89_0b_E9#,
                16#B1_B5_Db_Dd_8e_E8_1a_36#, 16#55_F8_3e_33_B2_27_9d_39#,
                16#Bf_3e_84_82_79_A7_22_C8#, 16#06_B4_85_A4_7e_67_C8_07#,
                16#B9_46_A3_37_Be_E8_94_26#, 16#74_27_88_59_E1_32_92_Fb#);

   	   Context.Init(Key3);
   	   Context.Final_Sign(Message3, 50, Tag);

       Assert((Tag = Temp) or (Context.Final_Verify(Message3, 50, Tag)), "Final Signature with SHA1 MAC failed.");
   
   end SHA512_MAC_Test3;

------------------------------------------------------------------------------------

end Test.SHA512_MAC;
