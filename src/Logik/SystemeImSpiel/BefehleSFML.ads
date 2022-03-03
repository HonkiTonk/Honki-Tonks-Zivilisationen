pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with EinheitStadtRecords;
with EinheitStadtDatentypen;
with SystemRecords;
with KartenDatentypen;

package BefehleSFML is
   
   function BefehleSFML
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return SystemDatentypen.Rückgabe_Werte_Enum;

private

   Transportiert : Boolean;
   AufgabeDurchführen : Boolean;
   StadtErfolgreichGebaut : Boolean;
   
   Auswahl : KartenDatentypen.UmgebungsbereichEins;
   
   Befehl : SystemDatentypen.Tastenbelegung_Enum;

   EinheitNummer : EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;
   TransporterNummer : EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;
   StadtNummer : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
   
   -- Ist Integer um mit dem aktuellen Auswahlsystem zu funktionieren.
   AusgewählteEinheit : Integer;
   
   StadtSuchenNachNamen : EinheitStadtRecords.RassePlatznummerRecord;
   
   NeuerName : SystemRecords.TextEingabeRecord;
   
   procedure AuswahlEinheitStadt
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);

   procedure EinheitOderStadt
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      StadtNummerExtern : in EinheitStadtDatentypen.MaximaleStädteMitNullWert;
      EinheitNummerExtern : in EinheitStadtDatentypen.MaximaleEinheitenMitNullWert);
   
   procedure BaueStadt
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);
   
   procedure EinheitBefehle
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      BefehlExtern : in SystemDatentypen.Tastenbelegung_Befehle_Enum);
   
   procedure StadtUmbenennen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);
   
   procedure StadtAbreißen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);
   
   procedure AuswahlEinheitTransporter
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);
   
   procedure StadtBetreten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);
   
   procedure EinheitSteuern
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);

end BefehleSFML;
