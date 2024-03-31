package body UmwandlungenVerzeichnisse is

   function Verzeichnispfad
     (SpielstandarteExtern : in SystemDatentypen.Spielstand_Enum)
      return String
   is begin
      
      return Encode (Item => To_Wide_Wide_String (Source => (Verzeichnispfade (SpielstandarteExtern))));
      
   end Verzeichnispfad;
   
   
   
   function Spielstandpfad
     (SpielstandarteExtern : in SystemDatentypen.Spielstand_Enum;
      SpielstandnameExtern : in Unbounded_Wide_Wide_String)
      return String
   is begin
      
      return Encode (Item => To_Wide_Wide_String (Source => (Spielstandpfade (SpielstandarteExtern)))) & Encode (Item => (To_Wide_Wide_String (Source => SpielstandnameExtern)));
      
   end Spielstandpfad;
     

end UmwandlungenVerzeichnisse;
