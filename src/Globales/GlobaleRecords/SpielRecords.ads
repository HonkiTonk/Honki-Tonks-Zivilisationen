pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with StadtDatentypen;
with EinheitenDatentypen;
with ForschungenDatentypen;
with ProduktionDatentypen;
with ZahlenDatentypen;
with RassenDatentypen;
with SpielDatentypen;
with DiplomatieDatentypen;

package SpielRecords is
   pragma Preelaborate;
   
   type ForschungRecord is record -- XXX
      
      TechnologieErforscht : ForschungenDatentypen.ErforschtArray;
      InvestierteForschung : ProduktionDatentypen.Produktion;
      
   end record;
   
   

   type WichtigesRecord is record
      
      Geldmenge : ZahlenDatentypen.EigenerInteger;
      GeldZugewinnProRunde : ProduktionDatentypen.Produktion;

      GesamteForschungsrate : ProduktionDatentypen.Lagermenge;
      Forschungsmenge : ProduktionDatentypen.Lagermenge;
      VerbleibendeForschungszeit : ProduktionDatentypen.Lagermenge;
      Forschungsprojekt : ForschungenDatentypen.ForschungIDMitNullWert;
      
      -- Wenn ich ein Record für diese Variable hier anlege, dann könnten man die bereits investierte Forschung behalten. XXX
      Erforscht : ForschungenDatentypen.ErforschtArray;
      
      AnzahlStädte : StadtDatentypen.MaximaleStädteMitNullWert;
      AnzahlArbeiter : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
      AnzahlKämpfer : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
      AnzahlSonstiges : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
      
      -- Einbau sinnvoll?
      -- GesamterAngriff : ProduktionDatentypen.Produktion;
      -- GesamteVerteidigung : ProduktionDatentypen.Produktion;
      
   end record;
   
   
   
   type DiplomatieRecord is record
      
      AktuellerZustand : DiplomatieDatentypen.Status_Untereinander_Enum;
      AktuelleSympathieBewertung : DiplomatieDatentypen.Meinung;
      ZeitSeitLetzterÄnderung : ZahlenDatentypen.EigenesNatural;
      
   end record;
   
   
   
   type GrenzenRecord is record
      
      Städtegrenze : StadtDatentypen.MaximaleStädte;
      Einheitengrenze : EinheitenDatentypen.MaximaleEinheiten;
      Geldgrenze : ZahlenDatentypen.EigenerInteger;
      Forschungsgrenze : ProduktionDatentypen.Produktion;
      Geldgewinngrenze : ProduktionDatentypen.Produktion;
      ForschungGewinngrenze : ProduktionDatentypen.Produktion;
      RassenRundengrenze : ZahlenDatentypen.EigenesNatural;
      
   end record;
   
   
   
   type AllgemeinesRecord is record
      
      Gewonnen : Boolean;
      Weiterspielen : Boolean;
      RasseAmZugNachLaden : RassenDatentypen.Rassen_Enum;
      Schwierigkeitsgrad : SpielDatentypen.Schwierigkeitsgrad_Enum;
      Rundenanzahl : Positive;
      Rundengrenze : Natural;   
      IronmanName : Unbounded_Wide_Wide_String;
      PlanetVernichtet : RassenDatentypen.Rassen_Enum;
      Zusammenbruchszeit : Integer;
      
   end record;
   
   
   
   type RassenRecords is record
      
      Belegung : RassenDatentypen.Spieler_Enum;
      Besiegt : Boolean;
      
   end record;

end SpielRecords;
