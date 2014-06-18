with AUnit.Assertions;
with Crypto.Asymmetric.DSA;
with Crypto.Types;
use Crypto.Types;

pragma Elaborate_All (Crypto.Asymmetric.DSA);

package body Test.DSA is

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   ----------------------------- Type - Declaration ----------------------------
   -----------------------------------------------------------------------------
--------------------------------------------------------------------------------

   package DSA is new  Crypto.Asymmetric.DSA(512);
   use DSA;

   P: constant DSA_Number := (16#8d#, 16#f2#, 16#a4#, 16#94#, 16#49#, 16#22#,
                      16#76#, 16#aa#, 16#3d#, 16#25#, 16#75#, 16#9b#,
                      16#b0#, 16#68#, 16#69#, 16#cb#, 16#ea#, 16#c0#,
                      16#d8#, 16#3a#, 16#fb#, 16#8d#, 16#0c#, 16#f7#,
                      16#cb#, 16#b8#, 16#32#, 16#4f#, 16#0d#, 16#78#,
                      16#82#, 16#e5#, 16#d0#, 16#76#, 16#2f#, 16#c5#,
                      16#b7#, 16#21#, 16#0e#, 16#af#, 16#c2#, 16#e9#,
                      16#ad#, 16#ac#, 16#32#, 16#ab#, 16#7a#, 16#ac#,
                      16#49#, 16#69#, 16#3d#, 16#fb#, 16#f8#, 16#37#,
                      16#24#, 16#c2#, 16#ec#, 16#07#, 16#36#, 16#ee#,
                      16#31#, 16#c8#, 16#02#, 16#91#);

    Q: DSA_Number := (others => 0);

   G: constant DSA_Number := (16#62#, 16#6d#, 16#02#, 16#78#, 16#39#, 16#ea#,
                      16#0a#, 16#13#, 16#41#, 16#31#, 16#63#, 16#a5#,
                      16#5b#, 16#4c#, 16#b5#, 16#00#, 16#29#, 16#9d#,
                      16#55#, 16#22#, 16#95#, 16#6c#, 16#ef#, 16#cb#,
                      16#3b#, 16#ff#, 16#10#, 16#f3#, 16#99#, 16#ce#,
                      16#2c#, 16#2e#, 16#71#, 16#cb#, 16#9d#, 16#e5#,
                      16#fa#, 16#24#, 16#ba#, 16#bf#, 16#58#, 16#e5#,
                      16#b7#, 16#95#, 16#21#, 16#92#, 16#5c#, 16#9c#,
                      16#c4#, 16#2e#, 16#9f#, 16#6f#, 16#46#, 16#4b#,
                      16#08#, 16#8c#, 16#c5#, 16#72#, 16#af#, 16#53#,
                      16#e6#, 16#d7#, 16#88#, 16#02#);

    X : DSA_Number := (others => 0);

   Y: constant DSA_Number :=
    	(16#19#, 16#13#, 16#18#, 16#71#, 16#d7#, 16#5b#, 16#16#, 16#12#,
    	 16#a8#, 16#19#, 16#f2#, 16#9d#, 16#78#, 16#d1#, 16#b0#, 16#d7#,
     	 16#34#, 16#6f#, 16#7a#, 16#a7#, 16#7b#, 16#b6#, 16#2a#, 16#85#,
     	 16#9b#, 16#fd#, 16#6c#, 16#56#, 16#75#, 16#da#, 16#9d#, 16#21#,
         16#2d#, 16#3a#, 16#36#, 16#ef#, 16#16#, 16#72#, 16#ef#, 16#66#,
         16#0b#, 16#8c#, 16#7c#, 16#25#, 16#5c#, 16#c0#, 16#ec#, 16#74#,
         16#85#, 16#8f#, 16#ba#, 16#33#, 16#f4#, 16#4c#, 16#06#, 16#69#,
         16#96#, 16#30#, 16#a7#, 16#6b#, 16#03#, 16#0e#, 16#e3#, 16#33#);

    Public_Key:  Public_Key_DSA;
    Private_Key: Private_Key_DSA;
    Signature:   Signature_DSA;
    P_1, Q_1, G_1, Y_1, X_1: DSA.DSA_Number;
    Public_Key_2:  Public_Key_DSA;
    Private_Key_2:  Private_Key_DSA;

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
-------------------------------- Register DSA Test 1 -------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

	procedure Register_Tests(T : in out DSA_Test) is
		use Test_Cases.Registration;
	begin

		Register_Routine(T, DSA_Test1'Access,"DSA Test1.");
		Register_Routine(T, DSA_Test2'Access,"DSA Test2.");
                Register_Routine(T, DSA_Test3'Access,"DSA Test3.");
                Register_Routine(T, DSA_Test4'Access,"DSA Test4.");
      		Register_Routine(T, DSA_Test5'Access,"DSA Test5.");
		Register_Routine(T, DSA_Test6'Access,"DSA_New Get Public/Private Key Test.");
		Register_Routine(T, DSA_Test7'Access,"DSA_New Get/Set Signature Test.");

	end Register_Tests;

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
----------------------------------- Name DSA Test ----------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

	function Name(T : DSA_Test) return Test_String is
	begin
		return new String'("DSA Test");
	end Name;

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------ Start Tests -----------------------------------
------------------------------------------------------------------------------------
-------------------------------------- Test 1 --------------------------------------
------------------------------------------------------------------------------------

   procedure DSA_Test1(T : in out Test_Cases.Test_Case'Class) is
      use AUnit.Assertions;
   begin

       Q(Q'Last-19..Q'Last) :=
        (16#c7#, 16#73#, 16#21#, 16#8c#, 16#73#, 16#7e#, 16#c8#, 16#ee#,
         16#99#, 16#3b#, 16#4f#, 16#2d#, 16#ed#, 16#30#, 16#f4#, 16#8e#,
         16#da#, 16#ce#, 16#91#, 16#5f#);

      X(X'Last-19..X'Last) :=
        (16#20#, 16#70#, 16#b3#, 16#22#, 16#3d#, 16#ba#, 16#37#, 16#2f#,
         16#de#, 16#1c#, 16#0f#, 16#fc#, 16#7b#, 16#2e#, 16#3b#, 16#49#,
         16#8b#, 16#26#, 16#06#, 16#14#);

      Set_Public_Key( P, Q, G, Y, Public_Key);
      Set_Private_Key(P, Q, G, X, Private_Key);

      Assert(Verify_Key_Pair(Private_Key, Public_Key), "DSA Key Pair verifying failed.");


   end DSA_Test1;

------------------------------------------------------------------------------------
-------------------------------------- Test 2 --------------------------------------
------------------------------------------------------------------------------------

   procedure DSA_Test2(T : in out Test_Cases.Test_Case'Class) is
      use AUnit.Assertions;
   begin

       Q(Q'Last-19..Q'Last) :=
        (16#c7#, 16#73#, 16#21#, 16#8c#, 16#73#, 16#7e#, 16#c8#, 16#ee#,
         16#99#, 16#3b#, 16#4f#, 16#2d#, 16#ed#, 16#30#, 16#f4#, 16#8e#,
         16#da#, 16#ce#, 16#91#, 16#5f#);

      X(X'Last-19..X'Last) :=
        (16#20#, 16#70#, 16#b3#, 16#22#, 16#3d#, 16#ba#, 16#37#, 16#2f#,
         16#de#, 16#1c#, 16#0f#, 16#fc#, 16#7b#, 16#2e#, 16#3b#, 16#49#,
         16#8b#, 16#26#, 16#06#, 16#14#);

      Set_Public_Key( P, Q, G, Y, Public_Key);
      Set_Private_Key(P, Q, G, X, Private_Key);

      Sign_File("hash_message2.txt", Private_Key, Signature);

      Assert(Verify_File("hash_message2.txt",Public_Key, Signature), "DSA verifying File Signature failed.");

      Sign_File("hash_message5.txt", Private_Key, Signature);

      Assert(Verify_File("hash_message5.txt",Public_Key, Signature), "DSA verifying File Signature failed.");

   end DSA_Test2;

------------------------------------------------------------------------------------
-------------------------------------- Test 3 --------------------------------------
------------------------------------------------------------------------------------

   procedure DSA_Test3(T : in out Test_Cases.Test_Case'Class) is
      use AUnit.Assertions;
   begin

       Q(Q'Last-19..Q'Last) :=
        (16#c7#, 16#73#, 16#21#, 16#8c#, 16#73#, 16#7e#, 16#c8#, 16#ee#,
         16#99#, 16#3b#, 16#4f#, 16#2d#, 16#ed#, 16#30#, 16#f4#, 16#8e#,
         16#da#, 16#ce#, 16#91#, 16#5f#);

      X(X'Last-19..X'Last) :=
        (16#20#, 16#70#, 16#b3#, 16#22#, 16#3d#, 16#ba#, 16#37#, 16#2f#,
         16#de#, 16#1c#, 16#0f#, 16#fc#, 16#7b#, 16#2e#, 16#3b#, 16#49#,
         16#8b#, 16#26#, 16#06#, 16#14#);

      Gen_Key(Public_Key, Private_Key);

      Assert(Verify_Key_Pair(Private_Key, Public_Key), "DSA Key Pair verifying failed.");

   end DSA_Test3;
------------------------------------------------------------------------------------
-------------------------------------- Test 4 --------------------------------------
------------------------------------------------------------------------------------
   procedure DSA_Test4(T : in out Test_Cases.Test_Case'Class) is
      use AUnit.Assertions;
      Is_same : Boolean := False;
   begin

      Q(Q'Last-19..Q'Last) :=
        (16#c7#, 16#73#, 16#21#, 16#8c#, 16#73#, 16#7e#, 16#c8#, 16#ee#,
         16#99#, 16#3b#, 16#4f#, 16#2d#, 16#ed#, 16#30#, 16#f4#, 16#8e#,
         16#da#, 16#ce#, 16#91#, 16#5f#);

      Set_Public_Key( P, Q, G, Y, Public_Key);
      Get_Public_Key( Public_Key, P_1, Q_1, G_1, Y_1);
      Set_Public_Key( P_1, Q_1, G_1, Y_1, Public_Key_2);

      If Public_Key =  Public_Key_2 then
         Is_same := True;
      end if;

      Assert(Is_same , "DSA Get Public Key failed.");

   end DSA_Test4;
------------------------------------------------------------------------------------
-------------------------------------- Test 5 --------------------------------------
------------------------------------------------------------------------------------
   procedure DSA_Test5(T : in out Test_Cases.Test_Case'Class) is
      use AUnit.Assertions;
      Is_same : Boolean := False;
   begin

      Q(Q'Last-19..Q'Last) :=
        (16#c7#, 16#73#, 16#21#, 16#8c#, 16#73#, 16#7e#, 16#c8#, 16#ee#,
         16#99#, 16#3b#, 16#4f#, 16#2d#, 16#ed#, 16#30#, 16#f4#, 16#8e#,
         16#da#, 16#ce#, 16#91#, 16#5f#);

      X(X'Last-19..X'Last) :=
        (16#20#, 16#70#, 16#b3#, 16#22#, 16#3d#, 16#ba#, 16#37#, 16#2f#,
         16#de#, 16#1c#, 16#0f#, 16#fc#, 16#7b#, 16#2e#, 16#3b#, 16#49#,
         16#8b#, 16#26#, 16#06#, 16#14#);

      Set_Private_Key( P, Q, G, X, Private_Key);
      Get_Private_Key( Private_Key, P_1, Q_1, G_1, X_1);
      Set_Private_Key( P_1, Q_1, G_1, X_1, Private_Key_2);

      If Private_Key =  Private_Key_2 then
         Is_same := True;
      end if;

      Assert(Is_same, "DSA Get Private Key failed.");

   end DSA_Test5;

------------------------------------------------------------------------------------
-------------------------------------- Test 6 --------------------------------------
------------------------------------------------------------------------------------

   procedure DSA_Test6(T : in out Test_Cases.Test_Case'Class) is
      use AUnit.Assertions;
      PComp, QComp, GComp, XComp, YComp : DSA_Number;
      valid : Boolean := true;

   begin

       Q(Q'Last-19..Q'Last) :=
        (16#c7#, 16#73#, 16#21#, 16#8c#, 16#73#, 16#7e#, 16#c8#, 16#ee#,
         16#99#, 16#3b#, 16#4f#, 16#2d#, 16#ed#, 16#30#, 16#f4#, 16#8e#,
         16#da#, 16#ce#, 16#91#, 16#5f#);

      X(X'Last-19..X'Last) :=
        (16#20#, 16#70#, 16#b3#, 16#22#, 16#3d#, 16#ba#, 16#37#, 16#2f#,
         16#de#, 16#1c#, 16#0f#, 16#fc#, 16#7b#, 16#2e#, 16#3b#, 16#49#,
         16#8b#, 16#26#, 16#06#, 16#14#);

      Set_Public_Key(P, Q, G, Y, Public_Key);
      Set_Private_Key(P, Q, G, X, Private_Key);

      Get_Public_Key(Public_Key, PComp, QComp, GComp, YComp);
      IF PComp/=P OR QComp/=Q OR GComp/=G OR YComp/=Y THEN
         valid:= false;
      end if;

      Get_Private_Key(Private_Key, PComp, QComp, GComp, XComp);
      IF PComp/=P OR QComp/=Q OR GComp/=G OR XComp/=X THEN
         valid:= false;
      end if;

      Assert(valid, "DSA Get Public/Private Key failed.");


   end DSA_Test6;

------------------------------------------------------------------------------------
-------------------------------------- Test 7 --------------------------------------
------------------------------------------------------------------------------------

   procedure DSA_Test7(T : in out Test_Cases.Test_Case'Class) is
      use AUnit.Assertions;
      RTemp, STemp : DSA.Big.Big_Unsigned;
      SignatureComp : Signature_DSA;
   begin

       Q(Q'Last-19..Q'Last) :=
        (16#c7#, 16#73#, 16#21#, 16#8c#, 16#73#, 16#7e#, 16#c8#, 16#ee#,
         16#99#, 16#3b#, 16#4f#, 16#2d#, 16#ed#, 16#30#, 16#f4#, 16#8e#,
         16#da#, 16#ce#, 16#91#, 16#5f#);

      X(X'Last-19..X'Last) :=
        (16#20#, 16#70#, 16#b3#, 16#22#, 16#3d#, 16#ba#, 16#37#, 16#2f#,
         16#de#, 16#1c#, 16#0f#, 16#fc#, 16#7b#, 16#2e#, 16#3b#, 16#49#,
         16#8b#, 16#26#, 16#06#, 16#14#);

      Set_Public_Key(P, Q, G, Y, Public_Key);
      Set_Private_Key(P, Q, G, X, Private_Key);

      Sign_File("hash_message2.txt", Private_Key, Signature);

      Get_Signature(Signature => Signature,
                    R         => RTemp,
                    S         => STemp);

      Set_Signature(R         => RTemp,
                    S         => STemp,
                    Signature => SignatureComp);

      Assert(Signature = SignatureComp, "DSA Get/Set Signature failed.");


   end DSA_Test7;


end Test.DSA;
