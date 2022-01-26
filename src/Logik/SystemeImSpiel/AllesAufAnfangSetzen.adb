pragma SPARK_Mode (On);

with GlobaleVariablen;
with KartenKonstanten;
with SonstigesKonstanten;
with SystemKonstanten;
with EinheitenKonstanten;
with StadtKonstanten;
with SystemDatentypen;

with Karten;
with DebugPlatzhalter;

package body AllesAufAnfangSetzen is

   procedure AllesAufAnfangSetzen
   is begin
      
      GlobaleVariablen.RassenImSpiel := (others => SystemDatentypen.Leer);
      GlobaleVariablen.EinheitenGebaut := (others => (others => EinheitenKonstanten.LeerEinheit));
      GlobaleVariablen.StadtGebaut := (others => (others => StadtKonstanten.LeerStadt));
      GlobaleVariablen.Wichtiges := (others => SonstigesKonstanten.LeerWichtigesZeug);
      GlobaleVariablen.Diplomatie := (others => (others => SonstigesKonstanten.LeerDiplomatie));
      GlobaleVariablen.RundenAnzahl := Positive'First;
      GlobaleVariablen.RasseAmZugNachLaden := EinheitenKonstanten.LeerRasse;
      GlobaleVariablen.CursorImSpiel := (others => SonstigesKonstanten.LeerCursor);
      GlobaleVariablen.Gewonnen := False;
      GlobaleVariablen.IronmanName := SystemKonstanten.LeerUnboundedString;
      GlobaleVariablen.WeiterSpielen := False;
      
      DebugPlatzhalter.DebugSieg := False;
      DebugPlatzhalter.FeindlicheInformationenSehen := False;

      Karten.Weltkarte := (others => (others => (others => KartenKonstanten.LeerWeltkarte)));
      Karten.KartenartGemischt := False;
            
   end AllesAufAnfangSetzen;

end AllesAufAnfangSetzen;
