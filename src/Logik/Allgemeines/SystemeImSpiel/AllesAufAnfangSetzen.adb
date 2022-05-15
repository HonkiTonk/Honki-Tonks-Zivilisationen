pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SonstigeVariablen;
with WichtigesKonstanten;
with TextKonstanten;
with EinheitenKonstanten;
with StadtKonstanten;
with RassenDatentypen;
with SpielVariablen;

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
            
   end AllesAufAnfangSetzen;

end AllesAufAnfangSetzen;
