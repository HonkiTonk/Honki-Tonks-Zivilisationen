pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GlobaleVariablen;
with WichtigesKonstanten;
with TextKonstanten;
with EinheitenKonstanten;
with StadtKonstanten;
with KartenRecordKonstanten;
with RassenDatentypen;

with Karten;
with DebugPlatzhalter;

package body AllesAufAnfangSetzen is

   procedure AllesAufAnfangSetzen
   is begin
      
      GlobaleVariablen.RassenImSpiel := (others => RassenDatentypen.Leer_Spieler_Enum);
      GlobaleVariablen.EinheitenGebaut := (others => (others => EinheitenKonstanten.LeerEinheit));
      GlobaleVariablen.StadtGebaut := (others => (others => StadtKonstanten.LeerStadt));
      GlobaleVariablen.Wichtiges := (others => WichtigesKonstanten.LeerWichtigesZeug);
      GlobaleVariablen.Diplomatie := (others => (others => WichtigesKonstanten.LeerDiplomatie));
      GlobaleVariablen.RundenAnzahl := Positive'First;
      GlobaleVariablen.RasseAmZugNachLaden := EinheitenKonstanten.LeerRasse;
      GlobaleVariablen.CursorImSpiel := (others => WichtigesKonstanten.LeerCursor);
      GlobaleVariablen.Gewonnen := False;
      GlobaleVariablen.IronmanName := TextKonstanten.LeerUnboundedString;
      GlobaleVariablen.WeiterSpielen := False;
      
      DebugPlatzhalter.DebugSieg := False;
      DebugPlatzhalter.FeindlicheInformationenSehen := False;

      Karten.Weltkarte := (others => (others => (others => KartenRecordKonstanten.LeerWeltkarte)));
      ------------------------- Karten wird nicht referenziert ohne das hier, warum auch immer.
      Karten.KartenartGemischt := False;
            
   end AllesAufAnfangSetzen;

end AllesAufAnfangSetzen;
