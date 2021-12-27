pragma SPARK_Mode (On);

package body InteraktionTasks is

   procedure FensterErzeugtÄndern
   is begin
      
      FensterErzeugt := not FensterErzeugt;
      
   end FensterErzeugtÄndern;
     
     
   
   procedure AktuelleRasseÄndern
     (RasseExtern : in SystemDatentypen.Rassen_Enum)
   is begin
      
      AktuelleRasse := RasseExtern;
      
   end AktuelleRasseÄndern;
   
   
   
   function FensterErzeugtAbrufen
     return Boolean
   is begin
      
      return FensterErzeugt;
      
   end FensterErzeugtAbrufen;
   
   
   
   function AktuelleRasseAbrufen
     return SystemDatentypen.Rassen_Enum
   is begin
      
      return AktuelleRasse;
      
   end AktuelleRasseAbrufen;
   
   
   
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
   
   
   
   procedure AktuelleMusikÄndern
     (MusikExtern : in SystemDatentypen.Musik_Aktuelle_Auswahl_Enum)
   is begin
      
      AktuelleMusik := MusikExtern;
      
   end AktuelleMusikÄndern;
   
   
   
   function AktuelleMusikAbfragen
     return SystemDatentypen.Musik_Aktuelle_Auswahl_Enum
   is begin
      
      return AktuelleMusik;
      
   end AktuelleMusikAbfragen;
   
end InteraktionTasks;
