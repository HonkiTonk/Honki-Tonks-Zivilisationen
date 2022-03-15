pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package body InteraktionGrafiktask is

   procedure ErzeugeFensterÄndern
   is begin
      
      ErzeugeFenster := not ErzeugeFenster;
      
   end ErzeugeFensterÄndern;
   
   
      
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
