pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, GlobaleKonstanten;
use GlobaleDatentypen;

package ImSpiel is

   function ImSpiel
     return Integer
     with
       Post =>
         (ImSpiel'Result in -1 .. 0);

private

   SichtbarkeitsprüfungNotwendig : Boolean;

   RassenSchleifeVerlassenKonstante : constant Integer := -300;

   AktuellerBefehlSpieler : Integer;
   RückgabeWert : Integer;
   RückgabeOptionen : Integer;
   RückgabeRassen : Integer;

   procedure BerechnungenNachZugendeAllerSpieler;



   function EinzelneRassenDurchgehen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Integer;

   function MenschlicherSpieler
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Integer
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = GlobaleDatentypen.Spieler_Mensch),
         Post =>
           (MenschlicherSpieler'Result in GlobaleKonstanten.RundeBeendenKonstante .. 5);

   function NochSpielerVorhanden
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Boolean;

end ImSpiel;
