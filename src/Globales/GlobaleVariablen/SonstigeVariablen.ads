pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen;
with EinheitenKonstanten;
with SystemRecords;

package SonstigeVariablen is

   -- Schlechte Lösung für die Umbelegung der Steuerung, später was besseres bauen.
   UmbelegungNummer : Positive;
   -- Schlechte Lösung für die Umbelegung der Steuerung, später was besseres bauen.

   Debug : SystemRecords.DebugRecord := (others => False);
   
   Gewonnen : Boolean := False;
   WeiterSpielen : Boolean := False;
   
   RassenImSpiel : RassenDatentypen.RassenImSpielArray := (others => RassenDatentypen.Leer_Spieler_Enum);
   RasseAmZugNachLaden : RassenDatentypen.Rassen_Enum := EinheitenKonstanten.LeerRasse;

end SonstigeVariablen;
