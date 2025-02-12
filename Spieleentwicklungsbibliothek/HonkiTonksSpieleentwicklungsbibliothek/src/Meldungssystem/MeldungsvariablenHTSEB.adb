package body MeldungsvariablenHTSEB is

   procedure FehlerMeldungWechseln
     (FehlerMeldungExtern : in Boolean)
   is begin
      
      FehlerMeldung := FehlerMeldungExtern;
      
   end FehlerMeldungWechseln;
   
   
   
   procedure VersionsnummerWechseln
     (VersionsnummerExtern : in Wide_Wide_String)
   is begin
      
      Versionsnummer := VersionsnummerExtern;
      
   end VersionsnummerWechseln;
   
   
   
   function FehlerMeldungAbfragen
     return Boolean
   is begin
      
      return FehlerMeldung;
      
   end FehlerMeldungAbfragen;
   
   
   
   function VersionsnummerAbfragen
     return Wide_Wide_String
   is begin
      
      return Versionsnummer;
      
   end VersionsnummerAbfragen;

end MeldungsvariablenHTSEB;
