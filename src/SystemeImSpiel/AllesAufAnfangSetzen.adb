pragma SPARK_Mode (On);

with GlobaleVariablen, GlobaleKonstanten, GlobaleDatentypen;

with Karten, Cheat;

package body AllesAufAnfangSetzen is

   procedure AllesAufAnfangSetzen
   is begin
      
      GlobaleVariablen.RassenImSpiel := (others => GlobaleDatentypen.Leer);
      GlobaleVariablen.EinheitenGebaut := (others => (others => GlobaleKonstanten.LeerEinheit));
      GlobaleVariablen.StadtGebaut := (others => (others => GlobaleKonstanten.LeerStadt));
      GlobaleVariablen.Wichtiges := (others => GlobaleKonstanten.LeerWichtigesZeug);
      GlobaleVariablen.Diplomatie := (others => (others => GlobaleKonstanten.LeerDiplomatie));
      GlobaleVariablen.RundenAnzahl := Positive'First;
      GlobaleVariablen.RasseAmZugNachLaden := GlobaleDatentypen.Leer;
      GlobaleVariablen.CursorImSpiel := (others => GlobaleKonstanten.LeerCursor);
      GlobaleVariablen.Gewonnen := False;
      GlobaleVariablen.IronmanName := GlobaleKonstanten.LeerUnboundedString;
      GlobaleVariablen.WeiterSpielen := False;
      
      Cheat.GewonnenDurchCheat := False;
      Cheat.FeindlicheInformationenSehen := False;

      Karten.Weltkarte := (others => (others => (others => GlobaleKonstanten.LeerWeltkarte)));
      Karten.KartenartGemischt := False;
            
   end AllesAufAnfangSetzen;

end AllesAufAnfangSetzen;
