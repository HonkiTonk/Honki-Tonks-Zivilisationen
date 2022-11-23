with RassenDatentypen;
with ZahlenDatentypen;
with ForschungenDatentypen;
with ProduktionDatentypen;
with SpielRecords;

with LeseRassenbelegung;

package SchreibeWichtiges is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   procedure Geldmenge
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      GeldZugewinnExtern : in ZahlenDatentypen.EigenerInteger;
      RechnenSetzenExtern : in Boolean)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure GeldZugewinnProRunde
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      GeldZugewinnExtern : in ProduktionDatentypen.Stadtproduktion;
      RechnenSetzenExtern : in Boolean)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure GesamteForschungsrate
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      ForschungsrateZugewinnExtern : in ProduktionDatentypen.Stadtproduktion;
      RechnenSetzenExtern : in Boolean)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure Forschungsmenge
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      ForschungZugewinnExtern : in ProduktionDatentypen.Produktion;
      RechnenSetzenExtern : in Boolean)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure VerbleibendeForschungszeit
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure Forschungsprojekt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      ForschungIDExtern : in ForschungenDatentypen.ForschungIDMitNullWert)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

   procedure Erforscht
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure ErforschtDebug
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure AnzahlStädte
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      PlusMinusExtern : in Boolean)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
     
   procedure AnzahlArbeiter
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      PlusMinusExtern : in Boolean)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
     
   procedure AnzahlKämpfer
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      PlusMinusExtern : in Boolean)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
     
   procedure AnzahlSonstiges
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      PlusMinusExtern : in Boolean)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure Standardeinstellungen;
   
   procedure LeerEintrag
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure GanzerEintrag
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      EintragExtern : in SpielRecords.WichtigesRecord);

end SchreibeWichtiges;
