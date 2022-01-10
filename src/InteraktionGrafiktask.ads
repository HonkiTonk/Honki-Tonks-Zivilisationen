pragma SPARK_Mode (On);

with SystemDatentypen;

package InteraktionGrafiktask is
    
   procedure ErzeugeFensterÄndern;
   procedure FensterVerändertÄndern;
   
   procedure EingabeÄndern
     (EingabeExtern : in SystemDatentypen.Welche_Eingabe_Enum);
   
   procedure AktuelleDarstellungÄndern
     (DarstellungExtern : in SystemDatentypen.Grafik_Aktuelle_Darstellung_Enum);
   
   
   
   function ErzeugeFensterAbrufen
     return Boolean;
   
   function FensterVerändertAbrufen
     return Boolean;
   
   function EingabeAbrufen
     return SystemDatentypen.Welche_Eingabe_Enum;
   
   function AktuelleDarstellungAbrufen
     return SystemDatentypen.Grafik_Aktuelle_Darstellung_Enum;
   
private

   ErzeugeFenster : Boolean := False;
   FensterVerändert : Boolean := False;
   
   Eingabe : SystemDatentypen.Welche_Eingabe_Enum := SystemDatentypen.Keine_Eingabe;
   
   AktuelleDarstellung : SystemDatentypen.Grafik_Aktuelle_Darstellung_Enum := SystemDatentypen.Grafik_SFML;

end InteraktionGrafiktask;
