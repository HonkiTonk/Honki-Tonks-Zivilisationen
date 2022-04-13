pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen;
with GrafikTonDatentypen;

package InteraktionGrafiktask is
   
   AktuellesMenü : SystemDatentypen.Welches_Menü_Enum := SystemDatentypen.Leer_Menü_Enum;
      
   type Fenster_Ändern_Enum is (
                                 Keine_Änderung_Enum,
                                 
                                 Bildrate_Ändern_Enum, Fenster_Verändert_Enum, Auflösung_Verändert_Enum, Modus_Verändert_Enum
                                );
   subtype Fenster_Wurde_Verändert_Enum is Fenster_Ändern_Enum range Fenster_Verändert_Enum .. Modus_Verändert_Enum;
   subtype Fenster_Unverändert_Enum is Fenster_Ändern_Enum range Keine_Änderung_Enum .. Bildrate_Ändern_Enum;
   FensterVerändert : Fenster_Ändern_Enum;
   
   TastenEingabe : Boolean := False;
   TextEingabe : Boolean := False;
   FensterGeschlossen : Boolean := False;
    
   procedure ErzeugeFensterÄndern;
   
   procedure EingabeÄndern
     (EingabeExtern : in SystemDatentypen.Welche_Eingabe_Enum);
   
   procedure AktuelleDarstellungÄndern
     (DarstellungExtern : in GrafikTonDatentypen.Grafik_Aktuelle_Darstellung_Enum);
   
   
   
   function ErzeugeFensterAbrufen
     return Boolean;
   
   function EingabeAbrufen
     return SystemDatentypen.Welche_Eingabe_Enum;
   
   function AktuelleDarstellungAbrufen
     return GrafikTonDatentypen.Grafik_Aktuelle_Darstellung_Enum;
   
private

   ErzeugeFenster : Boolean := False;
   
   Eingabe : SystemDatentypen.Welche_Eingabe_Enum := SystemDatentypen.Keine_Eingabe_Enum;
   
   AktuelleDarstellung : GrafikTonDatentypen.Grafik_Aktuelle_Darstellung_Enum := GrafikTonDatentypen.Grafik_SFML_Enum;

end InteraktionGrafiktask;
