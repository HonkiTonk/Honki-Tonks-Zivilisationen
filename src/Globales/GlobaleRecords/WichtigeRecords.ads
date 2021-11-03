pragma SPARK_Mode (On);

with EinheitStadtDatentypen;
with SystemDatentypen;

package WichtigeRecords is

   type WichtigesRecord is record
      
      Geldmenge : Integer;
      GeldZugewinnProRunde : EinheitStadtDatentypen.KostenLager;

      GesamteForschungsrate : EinheitStadtDatentypen.KostenLager;
      Forschungsmenge : EinheitStadtDatentypen.KostenLager;
      VerbleibendeForschungszeit : EinheitStadtDatentypen.KostenLager;
      Forschungsprojekt : EinheitStadtDatentypen.ForschungIDMitNullWert;

      Erforscht : EinheitStadtDatentypen.ErforschtArray;
      
      AnzahlStädte : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
      AnzahlArbeiter : EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;
      AnzahlKämpfer : EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;
      AnzahlSonstiges : EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;
      
      -- Einbau sinnvoll?
      -- GesamterAngriff : EinheitStadtDatentypen.KostenLager;
      -- GesamteVerteidigung : EinheitStadtDatentypen.KostenLager;
      
   end record;
   
   
   
   type DiplomatieRecord is record
      
      AktuellerZustand : SystemDatentypen.Status_Untereinander_Enum;
      AktuelleSympathieBewertung : EinheitStadtDatentypen.ProduktionFeld;
      ZeitSeitLetzterÄnderung : Natural;
      
   end record;
   
   
   
   type GrenzenRecord is record
      
      Städtegrenze : EinheitStadtDatentypen.MaximaleStädte;
      Einheitengrenze : EinheitStadtDatentypen.MaximaleEinheiten;
      Geldgrenze : Integer;
      Forschungsgrenze : EinheitStadtDatentypen.KostenLager;
      Geldgewinngrenze : EinheitStadtDatentypen.KostenLager;
      ForschungGewinngrenze : EinheitStadtDatentypen.KostenLager;
      RassenRundengrenze : Natural;
      
   end record;

end WichtigeRecords;
