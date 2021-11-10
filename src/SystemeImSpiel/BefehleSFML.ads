pragma SPARK_Mode (On);

with Sf.Window.Event;

with SystemDatentypen; use SystemDatentypen;
with EinheitStadtRecords;
with EinheitStadtDatentypen;

package BefehleSFML is
   
   function BefehleSFML
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return SystemDatentypen.Rückgabe_Werte_Enum;

private

   Transportiert : Boolean;
   AufgabeDurchführen : Boolean;
   NullWert : Boolean;
   
   Befehl : SystemDatentypen.Tastenbelegung_Enum;

   EinheitNummer : EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;
   EinheitTransportNummer : EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;
   StadtNummer : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
   
   StadtOderEinheit : Integer;
   
   BefehlNeu : Sf.Window.Event.sfEvent;
   
   StadtSuchenNachNamen : EinheitStadtRecords.RassePlatznummerRecord;
   
   procedure AuswahlEinheitStadt
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);

   procedure EinheitOderStadt
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      AuswahlExtern : in SystemDatentypen.Rückgabe_Werte_Enum;
      StadtNummerExtern : in EinheitStadtDatentypen.MaximaleStädteMitNullWert;
      EinheitNummerExtern : in EinheitStadtDatentypen.MaximaleEinheitenMitNullWert);
   
   procedure BaueStadt
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);
   
   procedure Technologie
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
