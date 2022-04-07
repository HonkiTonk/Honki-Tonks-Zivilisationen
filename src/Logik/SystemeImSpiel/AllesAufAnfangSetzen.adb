pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GlobaleVariablen;
with SonstigesKonstanten;
with TextKonstanten;
with EinheitenKonstanten;
with StadtKonstanten;
with KartenRecordKonstanten;
with SystemDatentypen;

with Karten;
with DebugPlatzhalter;

package body AllesAufAnfangSetzen is

   procedure AllesAufAnfangSetzen
   is begin
      
      GlobaleVariablen.RassenImSpiel := (others => SystemDatentypen.Leer_Spieler_Enum);
      GlobaleVariablen.EinheitenGebaut := (others => (others => EinheitenKonstanten.LeerEinheit));
      GlobaleVariablen.StadtGebaut := (others => (others => StadtKonstanten.LeerStadt));
      GlobaleVariablen.Wichtiges := (others => SonstigesKonstanten.LeerWichtigesZeug);
      GlobaleVariablen.Diplomatie := (others => (others => SonstigesKonstanten.LeerDiplomatie));
      GlobaleVariablen.RundenAnzahl := Positive'First;
      GlobaleVariablen.RasseAmZugNachLaden := EinheitenKonstanten.LeerRasse;
      GlobaleVariablen.CursorImSpiel := (others => SonstigesKonstanten.LeerCursor);
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
