with KartenRecordKonstanten;
with KartengeneratorRecordKonstanten;
with KartenartDatentypen;

with SchreibeWeltkarteneinstellungen;
with SchreibeWeltkarte;
with SchreibeWichtiges;
with SchreibeAllgemeines;
with SchreibeDiplomatie;
with SchreibeRassenbelegung;
with SchreibeCursor;
with SchreibeEinheitenGebaut;
with SchreibeStadtGebaut;

with KartengeneratorVariablenLogik;
with SichtweitenGrafik;

package body StandardSpielwerteSetzenLogik is

   procedure StandardSpielwerteSetzenLogik
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
      SchreibeStadtGebaut.Standardeinstellungen;
      SchreibeWichtiges.Standardeinstellungen;
      SchreibeDiplomatie.Standardeinstellungen;
      SchreibeCursor.Standardeinstellungen;
      SchreibeRassenbelegung.Standardeinstellungen; 
      SchreibeAllgemeines.Standardeinstellungen;
      
      SchreibeWeltkarteneinstellungen.Standardeinstellungen;
      SchreibeWeltkarte.Standardeinstellungen;
      
      SichtweitenGrafik.StandardSichtweiten;
      
   end StandardSpielwerteSetzenLogik;

end StandardSpielwerteSetzenLogik;
