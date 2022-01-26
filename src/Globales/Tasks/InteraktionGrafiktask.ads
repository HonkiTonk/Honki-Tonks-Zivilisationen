pragma SPARK_Mode (On);

with SystemDatentypen;

package InteraktionGrafiktask is
      
   type Fenster_Ändern_Enum is (Keine_Änderung, Bildrate_Ändern, Fenster_Verändert, Auflösung_Verändert, Modus_Verändert);
   subtype Fenster_Verändert_Enum is Fenster_Ändern_Enum range Fenster_Verändert .. Modus_Verändert;
   subtype Fenster_Unverändert_Enum is Fenster_Ändern_Enum range Keine_Änderung .. Bildrate_Ändern;
   FensterVerändert : Fenster_Ändern_Enum;
   
   TastenEingabe : Boolean := False;
   TextEingabe : Boolean := False;
    
   procedure ErzeugeFensterÄndern;
   
   procedure EingabeÄndern
     (EingabeExtern : in SystemDatentypen.Welche_Eingabe_Enum);
   
   procedure AktuelleDarstellungÄndern
     (DarstellungExtern : in SystemDatentypen.Grafik_Aktuelle_Darstellung_Enum);
   
   
   
   function ErzeugeFensterAbrufen
     return Boolean;
   
   function EingabeAbrufen
     return SystemDatentypen.Welche_Eingabe_Enum;
   
   function AktuelleDarstellungAbrufen
     return SystemDatentypen.Grafik_Aktuelle_Darstellung_Enum;
   
private

   ErzeugeFenster : Boolean := False;
   
   Eingabe : SystemDatentypen.Welche_Eingabe_Enum := SystemDatentypen.Keine_Eingabe;
   
   AktuelleDarstellung : SystemDatentypen.Grafik_Aktuelle_Darstellung_Enum := SystemDatentypen.Grafik_SFML;

end InteraktionGrafiktask;
