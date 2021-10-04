pragma SPARK_Mode (On);

with GlobaleVariablen, KartenKonstanten, SonstigesKonstanten, SystemKonstanten, EinheitenKonstanten, StadtKonstanten, SonstigeDatentypen;

with Karten, Cheat;

package body AllesAufAnfangSetzen is

   procedure AllesAufAnfangSetzen
   is begin
      
      GlobaleVariablen.RassenImSpiel := (others => SonstigeDatentypen.Leer);
      GlobaleVariablen.EinheitenGebaut := (others => (others => EinheitenKonstanten.LeerEinheit));
      GlobaleVariablen.StadtGebaut := (others => (others => StadtKonstanten.LeerStadt));
      GlobaleVariablen.Wichtiges := (others => SonstigesKonstanten.LeerWichtigesZeug);
      GlobaleVariablen.Diplomatie := (others => (others => SonstigesKonstanten.LeerDiplomatie));
      GlobaleVariablen.RundenAnzahl := Positive'First;
      GlobaleVariablen.RasseAmZugNachLaden := SonstigeDatentypen.Leer;
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
