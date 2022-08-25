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

with Karten;
with KartengeneratorVariablen;

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
            KartengeneratorVariablen.Polgrößen := KartenRecordKonstanten.Eisrand;
            KartengeneratorVariablen.Eisschild := KartenRecordKonstanten.Eisschild;
            KartengeneratorVariablen.Landgrößen := KartenRecordKonstanten.Kontinentgröße;
            KartengeneratorVariablen.Abstände := KartenRecordKonstanten.Kontinentabstand;
      end case;
      
      SpielVariablen.EinheitenGebaut := (others => (others => EinheitenRecordKonstanten.LeerEinheit));
      SpielVariablen.StadtGebaut := (others => (others => StadtRecordKonstanten.LeerStadt));
      SpielVariablen.Wichtiges := (others => WichtigesRecordKonstanten.LeerWichtigesZeug);
      SpielVariablen.Diplomatie := (others => (others => WichtigesRecordKonstanten.LeerDiplomatie));
      SpielVariablen.Allgemeines.Rundenanzahl := Positive'First;
      SpielVariablen.CursorImSpiel := (others => WichtigesRecordKonstanten.LeerCursor);
      SpielVariablen.Allgemeines.IronmanName := TextKonstanten.LeerUnboundedString;
      SpielVariablen.RassenImSpiel := (others => RassenDatentypen.Leer_Spieler_Enum);
      SpielVariablen.Allgemeines.RasseAmZugNachLaden := EinheitenKonstanten.LeerRasse;
      SpielVariablen.Allgemeines.Gewonnen := False;
      SpielVariablen.Allgemeines.Weiterspielen := False;
      SpielVariablen.Debug := (others => False);
      
      Karten.Karteneinstellungen := KartenRecordKonstanten.Standardkartenparameter;
      Karten.Weltkarte := (others => (others => (others => KartenRecordKonstanten.LeerWeltkarte)));
      Karten.Stadtkarte := (others => (others => (0)));
      
   end AllesAufAnfangSetzen;

end AllesAufAnfangSetzen;