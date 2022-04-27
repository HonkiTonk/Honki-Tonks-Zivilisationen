pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen;
with KartenRecordKonstanten;

with KartengeneratorHimmel;
with KartengeneratorWeltraum;
with KartengeneratorPlaneteninneres;
with Karten;
with KartengeneratorPolregion;
with KartengeneratorStandard;
with Fehler;
with KartengeneratorNurLand;
with KartengeneratorTotalesChaos;
with KartengeneratorChaos;
with LandwerteFestlegen;
with PolbereicheBerechnen;

package body KartengeneratorEisWasserLand is
   
   procedure AufteilungEisWasserLand
   is begin
      
      case
        Karten.Kartenparameter.Kartenart
      is
         when KartenDatentypen.Kartenart_Normal_Enum'Range | KartenDatentypen.Kartenart_Sonstiges_Enum'Range =>
            AllgemeineWerteFestlegen;
            KartengeneratorStandardSonstiges;
            
         when KartenDatentypen.Kartenart_Chaos_Enum =>
            KartengeneratorChaos.Chaos;
            
         when KartenDatentypen.Kartenart_Totales_Chaos_Enum =>
            KartengeneratorTotalesChaos.TotalesChaos;
      end case;
      
   end AufteilungEisWasserLand;
   
   
   
   procedure AllgemeineWerteFestlegen
   is
      
      task GrößeAbstand;
      task Pole;
      
      task body GrößeAbstand
      is begin
         
         LandwerteFestlegen.GrößeFestlegen;
         
      end GrößeAbstand;
      
      
      
      task body Pole
      is begin
         
         PolbereicheBerechnen.PolbereicheBerechnen;
         
      end Pole;
      
   begin
      
      Karten.Weltkarte := (others => (others => (others => KartenRecordKonstanten.LeerWeltkarte)));
      
   end AllgemeineWerteFestlegen;
      
   
  
   procedure KartengeneratorStandardSonstiges
   is
   
      task Himmel;
      task Weltraum;
      task Planeteninneres;
      
      task body Himmel
      is begin
         
         KartengeneratorHimmel.Himmel;
         
      end Himmel;
      
      
      
      task body Weltraum
      is begin

         KartengeneratorWeltraum.Weltraum;
         
      end Weltraum;
      
      
      
      task body Planeteninneres
      is begin
         
         KartengeneratorPlaneteninneres.Planeteninneres;
         
      end Planeteninneres;
   
   begin
      
      KartengeneratorPolregion.PolregionGenerieren;
      
      case
        Karten.Kartenparameter.Kartenart
      is
         when KartenDatentypen.Kartenart_Nur_Land_Enum =>
            KartengeneratorNurLand.NurLandGenerieren;
            
         when KartenDatentypen.Kartenart_Normal_Enum'Range =>
            KartengeneratorStandard.OberflächeGenerieren;
            
         when KartenDatentypen.Kartenart_Chaotisch_Enum'Range =>
            Fehler.LogikFehler (FehlermeldungExtern => "KartenGeneratorStandard.StandardKarte - Kartenart ist chaotisch.");
      end case;
      
   end KartengeneratorStandardSonstiges;

end KartengeneratorEisWasserLand;
