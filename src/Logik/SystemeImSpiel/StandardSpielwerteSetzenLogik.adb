with KartenRecordKonstanten;
with KartengeneratorRecordKonstanten;
with KartenartDatentypen;

with SchreibeWeltkarteneinstellungen;
with SchreibeWeltkarte;
with SchreibeWichtiges;
with SchreibeAllgemeines;
with SchreibeDiplomatie;
with SchreibeSpeziesbelegung;
with SchreibeZeiger;
with SchreibeEinheitenGebaut;
with SchreibeStadtGebaut;
with SchreibeKIVariablen;

with KartengeneratorVariablenLogik;
with SichtweitenGrafik;

package body StandardSpielwerteSetzenLogik is
   
   procedure Standardspielwerte
     (EinstellungenBehaltenExtern : in Boolean)
   is begin
      
      StandardspielwerteLogik (EinstellungenBehaltenExtern => EinstellungenBehaltenExtern);
      StandardspielwerteGrafik;
      
   end Standardspielwerte;
   
   

   procedure StandardspielwerteLogik
     (EinstellungenBehaltenExtern : in Boolean)
   is begin
      
      case
        EinstellungenBehaltenExtern
      is
         when True =>
            null;
            
         when False =>
            KartengeneratorVariablenLogik.Kartenparameter := KartenRecordKonstanten.Standardkartengeneratorparameter;
            KartengeneratorVariablenLogik.SenkrechtePolgrößen := KartengeneratorRecordKonstanten.SenkrechterEisrand;
            KartengeneratorVariablenLogik.Landgrößen := KartengeneratorRecordKonstanten.Kartenartgrößen (KartenartDatentypen.Kartenart_Kontinente_Enum);
      end case;
      
      SchreibeEinheitenGebaut.Standardeinstellungen;
      SchreibeEinheitenGebaut.Standardbewegungsplan;
      SchreibeStadtGebaut.Standardeinstellungen;
      SchreibeWichtiges.Standardeinstellungen;
      SchreibeDiplomatie.Standardeinstellungen;
      SchreibeZeiger.Standardeinstellungen;
      SchreibeSpeziesbelegung.Standardeinstellungen; 
      SchreibeAllgemeines.Standardeinstellungen;
      
      SchreibeKIVariablen.Standardeinstellungen;
      
      SchreibeWeltkarteneinstellungen.Standardeinstellungen;
      SchreibeWeltkarte.Standardeinstellungen;
      
   end StandardspielwerteLogik;
   
   
   
   procedure StandardspielwerteGrafik
   is begin
      
      SichtweitenGrafik.StandardSichtweiten;
      SichtweitenGrafik.StadtumgebungAbmessungBerechnen;
      
   end StandardspielwerteGrafik;

end StandardSpielwerteSetzenLogik;
