pragma SPARK_Mode (On);

with GlobaleVariablen, GlobaleDatentypen, KartenKonstanten, SonstigesKonstanten, SystemKonstanten, EinheitenKonstanten, StadtKonstanten;

with Karten, Cheat;

package body AllesAufAnfangSetzen is

   procedure AllesAufAnfangSetzen
   is begin
      
      GlobaleVariablen.RassenImSpiel := (others => GlobaleDatentypen.Leer);
      GlobaleVariablen.EinheitenGebaut := (others => (others => EinheitenKonstanten.LeerEinheit));
      GlobaleVariablen.StadtGebaut := (others => (others => StadtKonstanten.LeerStadt));
      GlobaleVariablen.Wichtiges := (others => SonstigesKonstanten.LeerWichtigesZeug);
      GlobaleVariablen.Diplomatie := (others => (others => SonstigesKonstanten.LeerDiplomatie));
      GlobaleVariablen.RundenAnzahl := Positive'First;
      GlobaleVariablen.RasseAmZugNachLaden := GlobaleDatentypen.Leer;
      GlobaleVariablen.CursorImSpiel := (others => SonstigesKonstanten.LeerCursor);
      GlobaleVariablen.Gewonnen := False;
      GlobaleVariablen.IronmanName := SystemKonstanten.LeerUnboundedString;
      GlobaleVariablen.WeiterSpielen := False;
      
      Cheat.GewonnenDurchCheat := False;
      Cheat.FeindlicheInformationenSehen := False;

      Karten.Weltkarte := (others => (others => (others => KartenKonstanten.LeerWeltkarte)));
      Karten.KartenartGemischt := False;
            
   end AllesAufAnfangSetzen;

end AllesAufAnfangSetzen;
