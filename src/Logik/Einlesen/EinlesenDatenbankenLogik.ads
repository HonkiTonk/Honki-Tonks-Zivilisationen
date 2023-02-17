with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

with EinheitenDatenbank;
with ForschungenDatenbank;
with ForschungRecordKonstanten;
with GebaeudeDatenbank;
with SpeziesDatenbank;

package EinlesenDatenbankenLogik is
   pragma Elaborate_Body;
   
   procedure AlleDatenbanken;
   procedure Einheiten;
   procedure Forschungen;
   procedure Gebäude;
   procedure Kartengrund;
   procedure Verbesserungen;
   procedure Spezies;
   
private
   
   PrüfungErfolgreich : Boolean;
   Nullwert : Boolean;
   
   DatenbankEinlesen : File_Type;
   
   Einheitenliste : EinheitenDatenbank.EinheitenlisteArray;
   
   Forschungsliste : ForschungenDatenbank.ForschungslisteArray;
   
   Verbesserungsforschung : ForschungRecordKonstanten.TechnologieVerbesserungenArray;
   
   Wegeforschung : ForschungRecordKonstanten.TechnologieWegeArray;
   
   Umgebungsforschung : ForschungRecordKonstanten.TechnologieUmgebungsgrößeArray;
   
   Gebäudeliste : GebaeudeDatenbank.GebäudelisteArray;
   
   Speziesliste : SpeziesDatenbank.SpezieslisteArray;
   
   
   
   function EinheitenDurchgehen
     (LadenPrüfenExtern : in Boolean)
      return Boolean;
   
   function ForschungenDurchgehen
     (LadenPrüfenExtern : in Boolean)
      return Boolean;
   
   function GebäudeDurchgehen
     (LadenPrüfenExtern : in Boolean)
      return Boolean;
   
   function SpeziesDurchgehen
     (LadenPrüfenExtern : in Boolean)
      return Boolean;

end EinlesenDatenbankenLogik;
