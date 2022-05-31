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
with KartengeneratorNurLand;
with PolbereicheBerechnen;

package body KartengeneratorAllgemeines is
   
   procedure GenerierungAllgemeines
   is begin
      
      Karten.Weltkarte := (others => (others => (others => KartenRecordKonstanten.LeerWeltkarte)));
      
      PolbereicheBerechnen.PolbereicheBerechnen;
      GenerierungGrundlagen;
      
   end GenerierungAllgemeines;
      
   
  
   procedure GenerierungGrundlagen
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
            
         when KartenDatentypen.Kartenart_Normal_Enum'Range | KartenDatentypen.Kartenart_Nutzerdefiniert_Enum =>
            KartengeneratorStandard.OberflächeGenerieren;
      end case;
      
   end GenerierungGrundlagen;

end KartengeneratorAllgemeines;
