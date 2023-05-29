with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

private with EinheitenDatenbank;
private with ForschungenDatenbank;
private with ForschungRecordKonstanten;
private with GebaeudeDatenbank;
private with SpeziesDatenbank;
private with VerbesserungenDatenbank;
private with KartenDatenbank;
private with EffekteDatenbank;

package EinlesenDatenbankenLogik is
   pragma Elaborate_Body;
   
   procedure AlleDatenbanken;
   procedure Einheiten;
   procedure Forschungen;
   procedure Gebäude;
   procedure Karten;
   procedure Verbesserungen;
   procedure Spezies;
   procedure Effekte;
   
private
   
   Nullwert : Boolean;
   
   DatenbankEinlesen : File_Type;
   
   Einheitenliste : EinheitenDatenbank.EinheitenlisteArray;
   
   Forschungsliste : ForschungenDatenbank.ForschungslisteArray;
   
   Verbesserungsforschung : ForschungRecordKonstanten.TechnologieVerbesserungenArray;
   
   Wegeforschung : ForschungRecordKonstanten.TechnologieWegeArray;
   
   Umgebungsforschung : ForschungRecordKonstanten.TechnologieUmgebungsgrößeArray;
   
   Gebäudeliste : GebaeudeDatenbank.GebäudelisteArray;
   
   Basisgrund : KartenDatenbank.BasisgrundlisteArray;
   
   Zusatzgrund : KartenDatenbank.ZusatzgrundlisteArray;
   
   Flüsse : KartenDatenbank.KartenflusslisteArray;
   
   Ressourcen : KartenDatenbank.KartenressourcenlisteArray;
   
   Verbesserung : VerbesserungenDatenbank.VerbesserungenlisteArray;
   
   Wege : VerbesserungenDatenbank.WegelisteArray;
   
   Speziesliste : SpeziesDatenbank.SpezieslisteArray;
   
   Effekteliste : EffekteDatenbank.EffektelisteArray;
   
   
   
   function EinheitenDurchgehen
     (LadenPrüfenExtern : in Boolean)
      return Boolean;
   
   function ForschungenDurchgehen
     (LadenPrüfenExtern : in Boolean)
      return Boolean;
   
   function GebäudeDurchgehen
     (LadenPrüfenExtern : in Boolean)
      return Boolean;
   
   function KartenDurchgehen
     (LadenPrüfenExtern : in Boolean)
      return Boolean;
   
   function VerbesserungenDurchgehen
     (LadenPrüfenExtern : in Boolean)
      return Boolean;
   
   function SpeziesDurchgehen
     (LadenPrüfenExtern : in Boolean)
      return Boolean;
   
   function EffekteDurchgehen
     (LadenPrüfenExtern : in Boolean)
      return Boolean;

end EinlesenDatenbankenLogik;
