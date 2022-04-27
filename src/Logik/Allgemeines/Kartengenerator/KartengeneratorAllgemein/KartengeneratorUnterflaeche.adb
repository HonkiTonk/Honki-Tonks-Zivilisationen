pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;

with LeseKarten;
with SchreibeKarten;

with Karten;
with KartengeneratorVariablen;

package body KartengeneratorUnterflaeche is

   procedure KartengeneratorUnterfläche
   is begin
      
      case
        Karten.Kartenparameter.Kartenart
      is
         when KartenDatentypen.Kartenart_Chaotisch_Enum'Range =>
            return;
            
         when KartenDatentypen.Kartenart_Normal_Enum'Range | KartenDatentypen.Kartenart_Sonstiges_Enum'Range =>
            null;
      end case;
               
      YAchseUnterwasserSchleife:
      for YAchseUnterwasserSchleifenwert in KartengeneratorVariablen.SchleifenanfangOhnePolbereich.YAchse .. KartengeneratorVariablen.SchleifenendeOhnePolbereich.YAchse loop
         XAchseUnterwasserSchleife:
         for XAchseUnterwasserSchleifenwert in KartengeneratorVariablen.SchleifenanfangOhnePolbereich.XAchse .. KartengeneratorVariablen.SchleifenendeOhnePolbereich.XAchse loop
            
            UnterflächeErzeugen (YAchseExtern => YAchseUnterwasserSchleifenwert,
                                  XAchseExtern => XAchseUnterwasserSchleifenwert);
               
         end loop XAchseUnterwasserSchleife;
      end loop YAchseUnterwasserSchleife;
      
   end KartengeneratorUnterfläche;
   
   
   
   procedure UnterflächeErzeugen
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
   is begin
      
      -- Wenn man den Funktionsaufruf nicht in das case verschiebt könnte man nach dem neusortieren des Kartengrund_Enum das als zusätzliche Prüfung ansehen.
      GrundOben := LeseKarten.Grund (KoordinatenExtern => (0, YAchseExtern, XAchseExtern));
      
      case
        GrundOben
      is
         when KartengrundDatentypen.Wasser_Enum =>
            GrundUnten := KartengrundDatentypen.Unterwasser_Enum;
            
         when KartengrundDatentypen.Küstengewässer_Enum =>
            GrundUnten := KartengrundDatentypen.Unterküstengewässer_Enum;
            
         when others =>
            GrundUnten := KartengrundDatentypen.Erde_Enum;
      end case;
      
      SchreibeKarten.Grund (KoordinatenExtern => (-1, YAchseExtern, XAchseExtern),
                            GrundExtern       => GrundUnten);
      
   end UnterflächeErzeugen;

end KartengeneratorUnterflaeche;
