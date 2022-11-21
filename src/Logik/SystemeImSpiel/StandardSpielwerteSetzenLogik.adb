with WichtigesRecordKonstanten;
with StadtRecordKonstanten;
with SpielVariablen;
with KartenRecordKonstanten;
with EinheitenRecordKonstanten;
with KartengeneratorRecordKonstanten;
with KartenartDatentypen;

with SchreibeWeltkarteneinstellungen;
with SchreibeWeltkarte;
with SchreibeWichtiges;
with SchreibeAllgemeines;

with KartengeneratorVariablenLogik;
with SichtweitenGrafik;

-- Das hier auch mal in die verschiedenen Zugriffsdateien aufteilen? äöü
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
      
      SpielVariablen.EinheitenGebaut := (others => (others => EinheitenRecordKonstanten.LeerEinheit));
      SpielVariablen.StadtGebaut := (others => (others => StadtRecordKonstanten.LeerStadt));
      SchreibeWichtiges.Standardeinstellungen;
      SpielVariablen.Diplomatie := (others => (others => WichtigesRecordKonstanten.StartDiplomatie));
      SpielVariablen.CursorImSpiel := (others => WichtigesRecordKonstanten.LeerCursor);
      SpielVariablen.Rassenbelegung := (others => WichtigesRecordKonstanten.LeerRassenbelegung);
      SchreibeAllgemeines.Standardeinstellungen;
      
      SchreibeWeltkarteneinstellungen.Standardeinstellungen;
      SchreibeWeltkarte.Standardeinstellungen;
      
      SpielVariablen.Debug := (others => False);
      
      SichtweitenGrafik.StandardSichtweiten;
      
   end StandardSpielwerteSetzenLogik;

end StandardSpielwerteSetzenLogik;
