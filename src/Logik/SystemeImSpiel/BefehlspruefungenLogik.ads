with RassenDatentypen;
with SpielVariablen;
with BefehleDatentypen;

private with EinheitenRecords;
private with EinheitenDatentypen;
private with StadtDatentypen;
private with StadtRecords;

with LeseRassenbelegung;

private with LeseGrenzen;

package BefehlspruefungenLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;
   
   procedure AuswahlEinheitStadt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
              );
   
   procedure WasWirdEntfernt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
              );
   
   procedure EinheitBefehle
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      BefehlExtern : in BefehleDatentypen.Einheiten_Aufgaben_Klein_Enum)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
              );
   
   procedure StadtUmbenennen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
              );
   
   procedure BaueStadt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
              );
   
private

   Transportiert : Boolean;
   LeerRückgabewert : Boolean;

   EinheitNummer : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   TransporterNummer : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   StadtNummer : StadtDatentypen.MaximaleStädteMitNullWert;
   
   -- Ist Integer um mit dem aktuellen Auswahlsystem zu funktionieren.
   AusgewählteEinheit : Integer;
   
      
   procedure EinheitOderStadt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      StadtNummerExtern : in StadtDatentypen.MaximaleStädteMitNullWert;
      EinheitNummerExtern : in EinheitenDatentypen.MaximaleEinheitenMitNullWert)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
               and
                 EinheitNummerExtern in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => RasseExtern)
               and
                 StadtNummerExtern in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => RasseExtern)
              );
   
   procedure StadtAktion
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => StadtRasseNummerExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
              );
   
   procedure AuswahlEinheitTransporter
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure EinheitSteuern
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );

end BefehlspruefungenLogik;
