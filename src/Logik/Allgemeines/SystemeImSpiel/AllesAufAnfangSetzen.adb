pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SonstigeVariablen;
with WichtigesKonstanten;
with TextKonstanten;
with EinheitenKonstanten;
with StadtKonstanten;
with RassenDatentypen;
with SpielVariablen;
with KartenRecordKonstanten;

with Karten;

package body AllesAufAnfangSetzen is

   procedure AllesAufAnfangSetzen
   is begin
      
      SpielVariablen.EinheitenGebaut := (others => (others => EinheitenKonstanten.LeerEinheit));
      SpielVariablen.StadtGebaut := (others => (others => StadtKonstanten.LeerStadt));
      SpielVariablen.Wichtiges := (others => WichtigesKonstanten.LeerWichtigesZeug);
      SpielVariablen.Diplomatie := (others => (others => WichtigesKonstanten.LeerDiplomatie));
      SpielVariablen.RundenAnzahl := Positive'First;
      SpielVariablen.CursorImSpiel := (others => WichtigesKonstanten.LeerCursor);
      SpielVariablen.IronmanName := TextKonstanten.LeerUnboundedString;
      
      SonstigeVariablen.RassenImSpiel := (others => RassenDatentypen.Leer_Spieler_Enum);
      SonstigeVariablen.RasseAmZugNachLaden := EinheitenKonstanten.LeerRasse;
      SonstigeVariablen.Gewonnen := False;
      SonstigeVariablen.WeiterSpielen := False;
      SonstigeVariablen.Debug := (others => False);
      
      Karten.Kartenparameter := KartenRecordKonstanten.KartenparameterStandard;
      Karten.Weltkarte := (others => (others => (others => KartenRecordKonstanten.LeerWeltkarte)));
      Karten.Stadtkarte := (others => (others => (0)));
      Karten.Polgrößen := KartenRecordKonstanten.Eisrand;
      Karten.Eisschild := KartenRecordKonstanten.Eisschild;
      Karten.Landgrößen := KartenRecordKonstanten.Inselgröße;
      Karten.Abstände := KartenRecordKonstanten.Inselabstand;
      
   end AllesAufAnfangSetzen;

end AllesAufAnfangSetzen;
