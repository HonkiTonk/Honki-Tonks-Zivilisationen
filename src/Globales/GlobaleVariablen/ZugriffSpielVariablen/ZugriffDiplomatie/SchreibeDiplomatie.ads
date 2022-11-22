with RassenDatentypen;
with DiplomatieDatentypen;
with ZahlenDatentypen;
with SpielRecords;

private with Grenzpruefungen;

with LeseRassenbelegung;

package SchreibeDiplomatie is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;
   use type RassenDatentypen.Rassen_Enum;

   procedure AktuellerZustand
     (RasseEinsExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      ZustandExtern : in DiplomatieDatentypen.Status_Untereinander_Enum)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseEinsExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 LeseRassenbelegung.Belegung (RasseExtern => RasseZweiExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 RasseEinsExtern /= RasseZweiExtern
              );
   
   procedure AktuelleSympathie
     (RasseEinsExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      SympathieExtern : in DiplomatieDatentypen.Meinung;
      RechnenSetzenExtern : in Boolean)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseEinsExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 LeseRassenbelegung.Belegung (RasseExtern => RasseZweiExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 RasseEinsExtern /= RasseZweiExtern
              );
   
   procedure ZeitSeitÄnderung
     (RasseEinsExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      ÄnderungExtern : in ZahlenDatentypen.EigenesNatural;
      RechnenSetzenExtern : in Boolean)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseEinsExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 LeseRassenbelegung.Belegung (RasseExtern => RasseZweiExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 RasseEinsExtern /= RasseZweiExtern
              );
   
   procedure Standardeinstellungen;
   
   procedure GanzerEintrag
     (RasseEinsExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      EintragExtern : in SpielRecords.DiplomatieRecord)
     with
       Pre => (
                 RasseEinsExtern /= RasseZweiExtern
              );
   
private
   
   function EigeneZahlPrüfen is new Grenzpruefungen.Standardprüfung (GanzeZahl => ZahlenDatentypen.EigenesNatural);
   
   function MeinungPrüfen is new Grenzpruefungen.Standardprüfung (GanzeZahl => DiplomatieDatentypen.Meinung);

end SchreibeDiplomatie;
