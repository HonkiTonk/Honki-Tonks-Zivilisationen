pragma SPARK_Mode (On);

package body InteraktionGrafiktask is

   procedure ErzeugeFensterÄndern
   is begin
      
      ErzeugeFenster := not ErzeugeFenster;
      
   end ErzeugeFensterÄndern;
   
   
   
   procedure FensterVerändertÄndern
   is begin
      
      FensterVerändert := not FensterVerändert;
      
   end FensterVerändertÄndern;
   
   
      
   procedure EingabeÄndern
     (EingabeExtern : in SystemDatentypen.Welche_Eingabe_Enum)
   is begin
      
      Eingabe := EingabeExtern;
      
   end EingabeÄndern;
   
   
      
   procedure AktuelleDarstellungÄndern
     (DarstellungExtern : in SystemDatentypen.Grafik_Aktuelle_Darstellung_Enum)
   is begin
      
      AktuelleDarstellung := DarstellungExtern;
      
   end AktuelleDarstellungÄndern;
   
   
   
   function ErzeugeFensterAbrufen
     return Boolean
   is begin
      
      return ErzeugeFenster;
      
   end ErzeugeFensterAbrufen;
   
   
      
   function FensterVerändertAbrufen
     return Boolean
   is begin
      
      return FensterVerändert;
      
   end FensterVerändertAbrufen;
   
   
   
   function EingabeAbrufen
     return SystemDatentypen.Welche_Eingabe_Enum
   is begin
      
      return Eingabe;
      
   end EingabeAbrufen;
   
   
   
   function AktuelleDarstellungAbrufen
     return SystemDatentypen.Grafik_Aktuelle_Darstellung_Enum
   is begin
      
      return AktuelleDarstellung;
      
   end AktuelleDarstellungAbrufen;

end InteraktionGrafiktask;
