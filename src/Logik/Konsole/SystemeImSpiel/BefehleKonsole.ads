pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Window.Event;

with RassenDatentypen;
with EinheitStadtRecords;
with EinheitStadtDatentypen;
with SystemRecords;
with TastenbelegungDatentypen;
with RueckgabeDatentypen;

package BefehleKonsole is

   function Befehle
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum;

private

   Transportiert : Boolean;
   AufgabeDurchführen : Boolean;
   NullWert : Boolean;
   
   Befehl : TastenbelegungDatentypen.Tastenbelegung_Enum;

   EinheitNummer : EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;
   EinheitTransportNummer : EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;
   StadtNummer : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
   
   StadtOderEinheit : Integer;
   
   BefehlNeu : Sf.Window.Event.sfEvent;
   
   StadtSuchenNachNamen : EinheitStadtRecords.RassePlatznummerRecord;
   
   NeuerName : SystemRecords.TextEingabeRecord;
   
   procedure AuswahlEinheitStadt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);

   procedure EinheitOderStadt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      AuswahlExtern : in RueckgabeDatentypen.Rückgabe_Werte_Enum;
      StadtNummerExtern : in EinheitStadtDatentypen.MaximaleStädteMitNullWert;
      EinheitNummerExtern : in EinheitStadtDatentypen.MaximaleEinheitenMitNullWert);
   
   procedure BaueStadt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);
   
   procedure Technologie
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);
   
   procedure EinheitBefehle
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      BefehlExtern : in TastenbelegungDatentypen.Tastenbelegung_Befehle_Enum);
   
   procedure StadtUmbenennen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);
   
   procedure StadtAbreißen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);
   
   procedure AuswahlEinheitTransporter
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);
   
   procedure StadtBetreten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);
   
   procedure EinheitSteuern
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);

end BefehleKonsole;