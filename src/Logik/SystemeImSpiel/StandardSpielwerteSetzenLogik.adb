pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with WichtigesRecordKonstanten;
with TextKonstanten;
with EinheitenKonstanten;
with StadtRecordKonstanten;
with SpielVariablen;
with KartenRecordKonstanten;
with EinheitenRecordKonstanten;
with WeltkarteRecords;
with KartengeneratorRecordKonstanten;

with Karten;
with KartengeneratorVariablen;
with Sichtweiten;

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
            KartengeneratorVariablen.Kartenparameter := KartenRecordKonstanten.Standardkartengeneratorparameter;
            KartengeneratorVariablen.Polgrößen := KartengeneratorRecordKonstanten.Eisrand;
            KartengeneratorVariablen.Landgrößen := KartengeneratorRecordKonstanten.Kontinentgröße;
      end case;
      
      SpielVariablen.EinheitenGebaut := (others => (others => EinheitenRecordKonstanten.LeerEinheit));
      SpielVariablen.StadtGebaut := (others => (others => StadtRecordKonstanten.LeerStadt));
      SpielVariablen.Wichtiges := (others => WichtigesRecordKonstanten.LeerWichtigesZeug);
      SpielVariablen.Diplomatie := (others => (others => WichtigesRecordKonstanten.StartDiplomatie));
      SpielVariablen.Allgemeines.Rundenanzahl := Positive'First;
      SpielVariablen.CursorImSpiel := (others => WichtigesRecordKonstanten.LeerCursor);
      SpielVariablen.Allgemeines.IronmanName := TextKonstanten.LeerUnboundedString;
      SpielVariablen.Rassenbelegung := (others => WichtigesRecordKonstanten.LeerRassenbelegung);
      SpielVariablen.Allgemeines.RasseAmZugNachLaden := EinheitenKonstanten.LeerRasse;
      SpielVariablen.Allgemeines.Gewonnen := False;
      SpielVariablen.Allgemeines.Weiterspielen := False;
      SpielVariablen.Debug := (others => False);
      
      Karten.Karteneinstellungen := KartenRecordKonstanten.Standardkartenparameter;
      Karten.Weltkarte := (others => (others => (others => WeltkarteRecords.LeerWeltkarte)));
      
      Sichtweiten.StandardSichtweiten;
      
   end StandardSpielwerteSetzenLogik;

end StandardSpielwerteSetzenLogik;
