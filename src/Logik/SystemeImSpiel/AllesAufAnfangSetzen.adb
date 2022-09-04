pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with WichtigesRecordKonstanten;
with TextKonstanten;
with EinheitenKonstanten;
with StadtRecordKonstanten;
with RassenDatentypen;
with SpielVariablen;
with KartenRecordKonstanten;
with EinheitenRecordKonstanten;
with WeltkarteRecords;
with KartengeneratorRecordKonstanten;

with Karten;
with KartengeneratorVariablen;
with Sichtweiten;

package body AllesAufAnfangSetzen is

   procedure AllesAufAnfangSetzen
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
            KartengeneratorVariablen.Eisschild := KartengeneratorRecordKonstanten.Eisschild;
            KartengeneratorVariablen.Landgrößen := KartengeneratorRecordKonstanten.Kontinentgröße;
            KartengeneratorVariablen.Abstände := KartengeneratorRecordKonstanten.Kontinentabstand;
      end case;
      
      SpielVariablen.EinheitenGebaut := (others => (others => EinheitenRecordKonstanten.LeerEinheit));
      SpielVariablen.StadtGebaut := (others => (others => StadtRecordKonstanten.LeerStadt));
      SpielVariablen.Wichtiges := (others => WichtigesRecordKonstanten.LeerWichtigesZeug);
      SpielVariablen.Diplomatie := (others => (others => WichtigesRecordKonstanten.StartDiplomatie));
      SpielVariablen.Allgemeines.Rundenanzahl := Positive'First;
      SpielVariablen.CursorImSpiel := (others => WichtigesRecordKonstanten.LeerCursor);
      SpielVariablen.Allgemeines.IronmanName := TextKonstanten.LeerUnboundedString;
      SpielVariablen.RassenImSpiel := (others => RassenDatentypen.Leer_Spieler_Enum);
      SpielVariablen.Allgemeines.RasseAmZugNachLaden := EinheitenKonstanten.LeerRasse;
      SpielVariablen.Allgemeines.Gewonnen := False;
      SpielVariablen.Allgemeines.Weiterspielen := False;
      SpielVariablen.Debug := (others => False);
      
      Karten.Karteneinstellungen := KartenRecordKonstanten.Standardkartenparameter;
      Karten.Weltkarte := (others => (others => (others => WeltkarteRecords.LeerWeltkarte)));
      Karten.Stadtkarte := (others => (others => (0)));
      
      Sichtweiten.StandardSichtweiten;
      
   end AllesAufAnfangSetzen;

end AllesAufAnfangSetzen;
