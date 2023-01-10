with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with StadtDatentypen;
with EinheitenDatentypen;
with ForschungenDatentypen;
with ProduktionDatentypen;
with ZahlenDatentypen;
with SpeziesDatentypen;
with SpielDatentypen;
with DiplomatieDatentypen;

package SpielRecords is
   pragma Preelaborate;
   
   type InvestierteForschungArray is array (ForschungenDatentypen.ErforschtArray'Range) of ProduktionDatentypen.Produktion;
   
   type ForschungRecord is record -- XXX
      
      TechnologieErforscht : ForschungenDatentypen.ErforschtArray;
      InvestierteForschung : InvestierteForschungArray;
      
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
      
      Städtegrenze : StadtDatentypen.MaximaleStädteMitNullWert;
      Einheitengrenze : EinheitenDatentypen.MaximaleEinheiten;
      Geldgrenze : ZahlenDatentypen.EigenesNatural;
      Forschungsgrenze : ProduktionDatentypen.Lagermenge;
      Geldgewinngrenze : ProduktionDatentypen.Lagermenge;
      ForschungGewinngrenze : ProduktionDatentypen.Lagermenge;
      SpeziesRundengrenze : ZahlenDatentypen.EigenesNatural;
      
   end record;
   
   
   
   type AllgemeinesRecord is record
      
      Gewonnen : Boolean;
      Weiterspielen : Boolean;
      SpeziesAmZugNachLaden : SpeziesDatentypen.Spezies_Enum;
      Schwierigkeitsgrad : SpielDatentypen.Schwierigkeitsgrad_Enum;
      Rundenanzahl : ZahlenDatentypen.EigenesPositive;
      Rundengrenze : ZahlenDatentypen.EigenesNatural;   
      IronmanName : Unbounded_Wide_Wide_String;
      PlanetVernichtet : SpeziesDatentypen.Spezies_Enum;
      Zusammenbruchszeit : ZahlenDatentypen.EigenerInteger;
      AnzahlEingesetzterPZB : ZahlenDatentypen.EigenesNatural;
      
   end record;
   
   
   
   type SpeziesRecords is record
      
      Belegung : SpeziesDatentypen.Spieler_Enum;
      Besiegt : Boolean;
      
   end record;
   
   type SpeziesbelegungArray is array (SpeziesDatentypen.Spezies_Verwendet_Enum'Range) of SpeziesRecords;

end SpielRecords;
