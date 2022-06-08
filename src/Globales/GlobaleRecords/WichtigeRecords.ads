pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with StadtDatentypen;
with EinheitenDatentypen;
with SystemDatentypen;
with ForschungenDatentypen;
with ProduktionDatentypen;
with ZahlenDatentypen;

package WichtigeRecords is
   
   type ForschungRecord is record -- XXX
      
      TechnologieErforscht : ForschungenDatentypen.ErforschtArray;
      InvestierteForschung : ProduktionDatentypen.Produktion;
      
   end record;
   
   

   type WichtigesRecord is record
      
      Geldmenge : ZahlenDatentypen.EigenerInteger;
      GeldZugewinnProRunde : ProduktionDatentypen.Produktion;

      GesamteForschungsrate : ProduktionDatentypen.Produktion;
      Forschungsmenge : ProduktionDatentypen.Produktion;
      VerbleibendeForschungszeit : ProduktionDatentypen.Produktion;
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
      
      AktuellerZustand : SystemDatentypen.Status_Untereinander_Enum;
      AktuelleSympathieBewertung : ProduktionDatentypen.Feldproduktion;
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

end WichtigeRecords;
