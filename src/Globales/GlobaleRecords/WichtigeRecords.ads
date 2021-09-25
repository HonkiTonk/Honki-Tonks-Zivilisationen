pragma SPARK_Mode (On);

with GlobaleDatentypen;

package WichtigeRecords is

   type WichtigesRecord is record
      
      Geldmenge : Integer;
      GeldZugewinnProRunde : GlobaleDatentypen.KostenLager;

      GesamteForschungsrate : GlobaleDatentypen.KostenLager;
      Forschungsmenge : GlobaleDatentypen.KostenLager;
      VerbleibendeForschungszeit : GlobaleDatentypen.KostenLager;
      Forschungsprojekt : GlobaleDatentypen.ForschungIDMitNullWert;

      Erforscht : GlobaleDatentypen.ErforschtArray;
      
      AnzahlStädte : GlobaleDatentypen.MaximaleStädteMitNullWert;
      AnzahlArbeiter : GlobaleDatentypen.MaximaleEinheitenMitNullWert;
      AnzahlKämpfer : GlobaleDatentypen.MaximaleEinheitenMitNullWert;
      AnzahlSonstiges : GlobaleDatentypen.MaximaleEinheitenMitNullWert;
      
      -- Einbau sinnvoll?
      -- GesamterAngriff : GlobaleDatentypen.KostenLager;
      -- GesamteVerteidigung : GlobaleDatentypen.KostenLager;
      
   end record;
   
   
   
   type DiplomatieRecord is record
      
      AktuellerZustand : GlobaleDatentypen.Status_Untereinander_Enum;
      AktuelleSympathieBewertung : GlobaleDatentypen.ProduktionFeld;
      ZeitSeitLetzterÄnderung : Natural;
      
   end record;
   
   
   
   type GrenzenRecord is record
      
      Städtegrenze : GlobaleDatentypen.MaximaleStädte;
      Einheitengrenze : GlobaleDatentypen.MaximaleEinheiten;
      Geldgrenze : Integer;
      Forschungsgrenze : GlobaleDatentypen.KostenLager;
      Geldgewinngrenze : GlobaleDatentypen.KostenLager;
      ForschungGewinngrenze : GlobaleDatentypen.KostenLager;
      RassenRundengrenze : Natural;
      
   end record;

end WichtigeRecords;
