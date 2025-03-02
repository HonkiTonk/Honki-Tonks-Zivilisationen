package body UmwandlungsvariablenHTSEB is

   procedure KodierungWechseln
     (KodierungExtern : in BetriebssystemDatentypenHTSEB.Kodierung_Enum)
   is begin
      
      case
        KodierungExtern
      is
         when BetriebssystemDatentypenHTSEB.UTF8_Enum =>
            Kodierung := Ada.Strings.UTF_Encoding.UTF_8;
            
         when BetriebssystemDatentypenHTSEB.UTF16BE_Enum =>
            Kodierung := Ada.Strings.UTF_Encoding.UTF_16BE;
            
         when BetriebssystemDatentypenHTSEB.UTF16LE_Enum =>
            Kodierung := Ada.Strings.UTF_Encoding.UTF_16LE;
      end case;
      
      
   end KodierungWechseln;
   
   
   
   procedure TrennzeichenWechseln
     (TrennzeichenExtern : in Wide_Wide_Character)
   is begin
      
      Trennzeichen := TrennzeichenExtern;
      
   end TrennzeichenWechseln;
   
   
   
   function KodierungAbfragen
     return Ada.Strings.UTF_Encoding.Encoding_Scheme
   is begin
      
      return Kodierung;
      
   end KodierungAbfragen;
   
   
   
   function TrennzeichenAbfragen
     return Wide_Wide_Character
   is begin
      
      return Trennzeichen;
      
   end TrennzeichenAbfragen;

end UmwandlungsvariablenHTSEB;
