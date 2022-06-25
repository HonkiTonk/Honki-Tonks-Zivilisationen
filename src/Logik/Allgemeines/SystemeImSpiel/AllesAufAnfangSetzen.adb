pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with WichtigesKonstanten;
with TextKonstanten;
with EinheitenKonstanten;
with StadtKonstanten;
with RassenDatentypen;
with SpielVariablen;
with KartenRecordKonstanten;

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
            KartengeneratorVariablen.Landgrößen := KartenRecordKonstanten.Inselgröße;
            KartengeneratorVariablen.Abstände := KartenRecordKonstanten.Inselabstand;
      end case;
      
      SpielVariablen.EinheitenGebaut := (others => (others => EinheitenKonstanten.LeerEinheit));
      SpielVariablen.StadtGebaut := (others => (others => StadtKonstanten.LeerStadt));
      SpielVariablen.Wichtiges := (others => WichtigesKonstanten.LeerWichtigesZeug);
      SpielVariablen.Diplomatie := (others => (others => WichtigesKonstanten.LeerDiplomatie));
      SpielVariablen.Allgemeines.Rundenanzahl := Positive'First;
      SpielVariablen.CursorImSpiel := (others => WichtigesKonstanten.LeerCursor);
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
