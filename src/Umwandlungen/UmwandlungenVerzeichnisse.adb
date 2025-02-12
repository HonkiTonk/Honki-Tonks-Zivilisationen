package body UmwandlungenVerzeichnisse is

   function Verzeichnispfad
     (SpielstandarteExtern : in SystemDatentypen.Spielstand_Enum)
      return String
   is begin
      
      return UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => (Verzeichnispfade (SpielstandarteExtern)));
      
   end Verzeichnispfad;
   
   
   
   function Spielstandpfad
     (SpielstandarteExtern : in SystemDatentypen.Spielstand_Enum;
      SpielstandnameExtern : in Unbounded_Wide_Wide_String)
      return String
   is begin
      
      return UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => (Spielstandpfade (SpielstandarteExtern))) & UmwandlungssystemHTSEB.EncodeUnbounded (TextExtern => SpielstandnameExtern);
      
   end Spielstandpfad;
     
end UmwandlungenVerzeichnisse;
