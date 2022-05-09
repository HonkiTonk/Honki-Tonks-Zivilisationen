pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with StadtDatentypen;
with EinheitenDatentypen;
with SystemDatentypen;
with ForschungenDatentypen;
with ProduktionDatentypen;

package WichtigeRecords is
   
   type ForschungRecord is record -- XXX
      
      TechnologieErforscht : ForschungenDatentypen.ErforschtArray;
      InvestierteForschung : ProduktionDatentypen.KostenLager;
      
   end record;
   
   

   type WichtigesRecord is record
      
      Geldmenge : Integer;
      GeldZugewinnProRunde : ProduktionDatentypen.KostenLager;

      GesamteForschungsrate : ProduktionDatentypen.KostenLager;
      Forschungsmenge : ProduktionDatentypen.KostenLager;
      VerbleibendeForschungszeit : ProduktionDatentypen.KostenLager;
      Forschungsprojekt : ForschungenDatentypen.ForschungIDMitNullWert;
      
      -- Wenn ich ein Record für diese Variable hier anlege, dann könnten man die bereits investierte Forschung behalten. XXX
      Erforscht : ForschungenDatentypen.ErforschtArray;
      
      AnzahlStädte : StadtDatentypen.MaximaleStädteMitNullWert;
      AnzahlArbeiter : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
      AnzahlKämpfer : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
      AnzahlSonstiges : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
      
      -- Einbau sinnvoll?
      -- GesamterAngriff : ProduktionDatentypen.KostenLager;
      -- GesamteVerteidigung : ProduktionDatentypen.KostenLager;
      
   end record;
   
   
   
   type DiplomatieRecord is record
      
      AktuellerZustand : SystemDatentypen.Status_Untereinander_Enum;
      AktuelleSympathieBewertung : ProduktionDatentypen.ProduktionFeld;
      ZeitSeitLetzterÄnderung : Natural;
      
   end record;
   
   
   
   type GrenzenRecord is record
      
      Städtegrenze : StadtDatentypen.MaximaleStädte;
      Einheitengrenze : EinheitenDatentypen.MaximaleEinheiten;
      Geldgrenze : Integer;
      Forschungsgrenze : ProduktionDatentypen.KostenLager;
      Geldgewinngrenze : ProduktionDatentypen.KostenLager;
      ForschungGewinngrenze : ProduktionDatentypen.KostenLager;
      RassenRundengrenze : Natural;
      
   end record;

end WichtigeRecords;
