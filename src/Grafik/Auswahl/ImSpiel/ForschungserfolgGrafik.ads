pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with Sf.System.Vector2;

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;

private with GrafikRecordKonstanten;

package ForschungserfolgGrafik is

   procedure Forschungserfolg
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      AuswahlExtern : in Natural)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
              );
   
private
   
   Viewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartgrößeView;

end ForschungserfolgGrafik;
