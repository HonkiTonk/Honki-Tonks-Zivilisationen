pragma SPARK_Mode (On);

with GlobaleTexte, GlobaleVariablen, GlobaleDatentypen;
use GlobaleDatentypen;

with LeseWichtiges;

with Anzeige, Eingabe, Cheat;

package body SiegBedingungen is

   procedure SiegBedingungen
   is begin
      
      case
        GlobaleVariablen.Gewonnen
      is
         when True =>
            null;
            
         when False =>
            SiegBedingungenPrüfen;
      end case;
      
   end SiegBedingungen;
      
      
      
   procedure SiegBedingungenPrüfen
   is begin
         
      VorhandeneRassen := 0;
      
      RassenSchleife:
      for RassenSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           GlobaleVariablen.RassenImSpiel (RassenSchleifenwert) /= GlobaleDatentypen.Leer
         then
            VorhandeneRassen := VorhandeneRassen + 1;
            
         else
            null;
         end if;
         
      end loop RassenSchleife;
      
      case
        VorhandeneRassen
      is
         when 1 =>
            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Zeug,
                                           TextDateiExtern        => GlobaleTexte.Gewonnen,
                                           ÜberschriftZeileExtern => 50,
                                           ErsteZeileExtern       => 1,
                                           LetzteZeileExtern      => 1,
                                           AbstandAnfangExtern    => GlobaleTexte.Leer,
                                           AbstandMitteExtern     => GlobaleTexte.Leer,
                                           AbstandEndeExtern      => GlobaleTexte.Neue_Zeile);
            GlobaleVariablen.Gewonnen := True;
            Eingabe.WartenEingabe;
            return;
            
         when others =>
            null;
      end case;
      
      RassenGeldSchleife:
      for RassenGeldSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           LeseWichtiges.Geldmenge (RasseExtern => RassenGeldSchleifenwert) = Integer'Last
         then
            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Zeug,
                                           TextDateiExtern        => GlobaleTexte.Gewonnen,
                                           ÜberschriftZeileExtern => 50,
                                           ErsteZeileExtern       => 2,
                                           LetzteZeileExtern      => 2,
                                           AbstandAnfangExtern    => GlobaleTexte.Leer,
                                           AbstandMitteExtern     => GlobaleTexte.Leer,
                                           AbstandEndeExtern      => GlobaleTexte.Neue_Zeile);
            GlobaleVariablen.Gewonnen := True;
            Eingabe.WartenEingabe;
            return;
            
         else
            null;
         end if;
         
      end loop RassenGeldSchleife;
      
      case
        Cheat.GewonnenDurchCheat
      is
         when False =>
            null;
            
         when True =>
            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Zeug,
                                           TextDateiExtern        => GlobaleTexte.Gewonnen,
                                           ÜberschriftZeileExtern => 50,
                                           ErsteZeileExtern       => 3,
                                           LetzteZeileExtern      => 3,
                                           AbstandAnfangExtern    => GlobaleTexte.Leer,
                                           AbstandMitteExtern     => GlobaleTexte.Leer,
                                           AbstandEndeExtern      => GlobaleTexte.Neue_Zeile);
            GlobaleVariablen.Gewonnen := True;
            Eingabe.WartenEingabe;
            return;
      end case;
         
   end SiegBedingungenPrüfen;

end SiegBedingungen;
