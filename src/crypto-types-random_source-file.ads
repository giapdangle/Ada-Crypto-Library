with Ada.Streams.Stream_IO;
with Ada.Strings.Unbounded;

package Crypto.Types.Random_Source.File is
   package Rnd renames Crypto.Types.Random_Source;

   type Random_Source_File is new Rnd.Random_Source with private;
   type Random_Source_File_Access is access  Random_Source_File;

   Overriding
   procedure Finalize(This : in out  Random_Source_File);

   Overriding
   procedure Initialize(This : in out Random_Source_File);

   procedure Initialize(This : in out Random_Source_File;
			File_Path : in String);
   Overriding
   procedure Read(This : in out Random_Source_File; B : out Byte);

   Overriding
   procedure Read(This : in out Random_Source_File; Byte_Array : out Bytes);

   Overriding
   procedure Read(This : in out Random_Source_File; B : out B_Block128);

   Overriding
   procedure Read(This : in out Random_Source_File; W : out Word);

   Overriding
   Procedure Read(This : in out Random_Source_File; Word_Array : out Words);

   Overriding
   procedure Read(This : in out Random_Source_File; D : out DWord);

   Overriding
   procedure Read(This : in out Random_Source_File; DWord_Array : out DWords);
private
   type File_Access is access Ada.Streams.Stream_IO.File_Type;

   type Random_Source_File is new Rnd.Random_Source with
      record
	      Source_Path : Ada.Strings.Unbounded.Unbounded_String;
         Source_File : File_Access;
      end record;

   function Path_Starts_With(This : Random_Source_File; S : String)
      return Boolean;

end Crypto.Types.Random_Source.File;
