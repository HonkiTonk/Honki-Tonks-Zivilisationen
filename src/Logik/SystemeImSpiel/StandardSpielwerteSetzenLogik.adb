with KartenRecordKonstanten;
with KartengeneratorRecordKonstanten;
with KartenartDatentypen;

with SchreibeWeltkarteneinstellungen;
with SchreibeWeltkarte;
with SchreibeWichtiges;
with SchreibeAllgemeines;
with SchreibeDiplomatie;
with SchreibeSpeziesbelegung;
with SchreibeCursor;
with SchreibeEinheitenGebaut;
with SchreibeStadtGebaut;

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
            KartengeneratorVariablenLogik.Polgrößen := KartengeneratorRecordKonstanten.Eisrand;
            KartengeneratorVariablenLogik.Landgrößen := KartengeneratorRecordKonstanten.Kartenartgrößen (KartenartDatentypen.Kartenart_Kontinente_Enum);
      end case;
      
      SchreibeEinheitenGebaut.Standardeinstellungen;
      SchreibeEinheitenGebaut.Standardbewegungsplan;
      SchreibeStadtGebaut.Standardeinstellungen;
      SchreibeWichtiges.Standardeinstellungen;
      SchreibeDiplomatie.Standardeinstellungen;
      SchreibeCursor.Standardeinstellungen;
      SchreibeSpeziesbelegung.Standardeinstellungen; 
      SchreibeAllgemeines.Standardeinstellungen;
      
      SchreibeWeltkarteneinstellungen.Standardeinstellungen;
      SchreibeWeltkarte.Standardeinstellungen;
      
   end StandardspielwerteLogik;
   
   
   
   procedure StandardspielwerteGrafik
   is begin
      
      SichtweitenGrafik.StandardSichtweiten;
      SichtweitenGrafik.StadtumgebungAbmessungBerechnen;
      
   end StandardspielwerteGrafik;

end StandardSpielwerteSetzenLogik;
