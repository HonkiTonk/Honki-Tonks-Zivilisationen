pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

with RassenDatentypen; use RassenDatentypen;
with SystemRecords;
with SonstigeVariablen;

package Speichern is

   procedure Speichern
     (AutospeichernExtern : in Boolean);

   procedure AutoSpeichern;

private

   SpielstandVorhanden : Boolean;

   AutospeichernWert : Positive := 1;

   DateiSpeichern : File_Type;

   NameSpielstand : SystemRecords.TextEingabeRecord;

   procedure Allgemeines;
   procedure Karte;
   procedure RassenwerteSpeichern;

   procedure FortschrittErhöhen
     (AutospeichernExtern : in Boolean);

   procedure Rassenwerte
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum);



   function SpielstandNameFestlegen
     (AutospeichernExtern : in Boolean)
      return SystemRecords.TextEingabeRecord;

   function NameAutoSpeichern
     return SystemRecords.TextEingabeRecord;

   function NameNutzer
     return SystemRecords.TextEingabeRecord;

end Speichern;
