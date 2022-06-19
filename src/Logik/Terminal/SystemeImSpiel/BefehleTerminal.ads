pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Window.Event;

with RassenDatentypen; use RassenDatentypen;
with EinheitenRecords;
with EinheitenDatentypen;
with StadtDatentypen;
with SystemRecords;
with TastenbelegungDatentypen;
with RueckgabeDatentypen;
with StadtRecords;
with SpielVariablen;
with SonstigeVariablen;

package BefehleTerminal is

   function Befehle
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum);

private

   Transportiert : Boolean;
   AufgabeDurchführen : Boolean;
   NullWert : Boolean;
   
   Befehl : TastenbelegungDatentypen.Tastenbelegung_Enum;

   EinheitNummer : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   EinheitTransportNummer : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   StadtNummer : StadtDatentypen.MaximaleStädteMitNullWert;
   
   StadtOderEinheit : Integer;
   
   BefehlNeu : Sf.Window.Event.sfEvent;
   
   StadtSuchenNachNamen : StadtRecords.RasseStadtnummerRecord;
   
   NeuerName : SystemRecords.TextEingabeRecord;
   
   procedure AuswahlEinheitStadt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum);

   procedure EinheitOderStadt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      AuswahlExtern : in RueckgabeDatentypen.Rückgabe_Werte_Enum;
      StadtNummerExtern : in StadtDatentypen.MaximaleStädteMitNullWert;
      EinheitNummerExtern : in EinheitenDatentypen.MaximaleEinheitenMitNullWert)
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
          and
            EinheitNummerExtern in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (RasseExtern).Einheitengrenze
          and
            StadtNummerExtern in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (RasseExtern).Städtegrenze);
   
   procedure BaueStadt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum);
   
   procedure Technologie
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum);
   
   procedure EinheitBefehle
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      BefehlExtern : in TastenbelegungDatentypen.Tastenbelegung_Befehle_Enum)
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum);
   
   procedure StadtUmbenennen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum);
   
   procedure StadtAbreißen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum);
   
   procedure AuswahlEinheitTransporter
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);
   
   procedure StadtBetreten
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);
   
   procedure EinheitSteuern
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);

end BefehleTerminal;
