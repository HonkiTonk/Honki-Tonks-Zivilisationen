pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartengrundDatentypen;

with LeseKarten;

with Karten;
with KartengeneratorVariablen;
with KartengeneratorErdwelt;
with KartengeneratorWasserwelt;
with Fehler;

package body KartengeneratorUnterwasserUnterirdisch is

   procedure GenerierungLandschaft
   is begin
      
      case
        Karten.Kartenparameter.Kartenart
      is
         when KartenDatentypen.Kartenart_Chaotisch_Enum'Range =>
            return;
            
         when KartenDatentypen.Kartenart_Normal_Enum'Range | KartenDatentypen.Kartenart_Sonstiges_Enum'Range =>
            null;
      end case;
               
      YAchseSchleife:
      for YAchseSchleifenwert in KartengeneratorVariablen.SchleifenanfangOhnePolbereich.YAchse .. KartengeneratorVariablen.SchleifenendeOhnePolbereich.YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartengeneratorVariablen.SchleifenanfangOhnePolbereich.XAchse .. KartengeneratorVariablen.SchleifenendeOhnePolbereich.XAchse loop
            
            case
              LeseKarten.Grund (KoordinatenExtern => (-1, YAchseSchleifenwert, XAchseSchleifenwert))
            is
               when KartengrundDatentypen.Erde_Enum =>               
                  KartengeneratorErdwelt.KartengeneratorErdwelt (YAchseExtern => YAchseSchleifenwert,
                                                                 XAchseExtern => XAchseSchleifenwert);
                  
               when KartengrundDatentypen.Unterwasser_Enum | KartengrundDatentypen.Unterküstengewässer_Enum =>
                  KartengeneratorWasserwelt.KartengeneratorWasserwelt (YAchseExtern => YAchseSchleifenwert,
                                                                       XAchseExtern => XAchseSchleifenwert);
                  
               when others =>
                  Fehler.LogikFehler (FehlermeldungExtern => "KartenGeneratorUnterwasserUnterirdisch.GenerierungLandschaft - Weder Wasser noch Erde.");
            end case;
               
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end GenerierungLandschaft;

end KartengeneratorUnterwasserUnterirdisch;
