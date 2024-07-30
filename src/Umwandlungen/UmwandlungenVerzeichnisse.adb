package body UmwandlungenVerzeichnisse is

   function Verzeichnispfad
     (SpielstandarteExtern : in SystemDatentypen.Spielstand_Enum)
      return String
   is begin
      
      return UmwandlungenAdaEigenes.EigenesEncodeUnbounded (TextExtern => (Verzeichnispfade (SpielstandarteExtern)));
      
   end Verzeichnispfad;
   
   
   
   function Spielstandpfad
     (SpielstandarteExtern : in SystemDatentypen.Spielstand_Enum;
      SpielstandnameExtern : in Unbounded_Wide_Wide_String)
      return String
   is begin
      
      return UmwandlungenAdaEigenes.EigenesEncodeUnbounded (TextExtern => (Spielstandpfade (SpielstandarteExtern))) & UmwandlungenAdaEigenes.EigenesEncodeUnbounded (TextExtern => SpielstandnameExtern);
      
   end Spielstandpfad;
     
end UmwandlungenVerzeichnisse;
