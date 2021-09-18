pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded;
use Ada.Strings.Wide_Wide_Unbounded;

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
      GlobaleVariablen.IronmanName := To_Unbounded_Wide_Wide_String (Source => "");
      Cheat.GewonnenDurchCheat := False;
      Cheat.FeindlicheInformationenSehen := False;
      GlobaleVariablen.WeiterSpielen := False;

      Karten.Weltkarte := (others => (others => (others => GlobaleKonstanten.LeerWeltkarte)));
      Karten.KartenartGemischt := False;
            
   end AllesAufAnfangSetzen;

end AllesAufAnfangSetzen;
