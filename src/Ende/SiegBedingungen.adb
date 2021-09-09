pragma SPARK_Mode (On);

with GlobaleTexte, GlobaleVariablen, GlobaleDatentypen;
use GlobaleDatentypen;

with LeseWichtiges;

with Anzeige, Eingabe, Cheat, Enden;

package body SiegBedingungen is

   function SiegBedingungen
     return Boolean
   is begin
      
      case
        SiegBedingungEins
      is
         when True =>
            Enden.EndeEins;
            return True;
            
         when False =>
            null;
      end case;
      
      case
        SiegBedingungZwei
      is
         when True =>
            Enden.EndeEins;
            return True;
            
         when False =>
            null;
      end case;
      
      case
        SiegBedingungDrei
      is
         when True =>
            Enden.EndeEins;
            return True;
            
         when False =>
            null;
      end case;
      
      return False;
      
   end SiegBedingungen;
      
      
      
   function SiegBedingungEins
     return Boolean
   is begin
         
      VorhandeneRassen := 0;
      
      RassenSchleife:
      for RassenSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           GlobaleVariablen.RassenImSpiel (RassenSchleifenwert)
         is
            when GlobaleDatentypen.Leer =>
               null;
               
            when others =>
               VorhandeneRassen := VorhandeneRassen + 1;
         end case;
         
         case
           VorhandeneRassen
         is
            when 0 .. 1 =>
               null;
               
            when others =>
               exit RassenSchleife;
         end case;
         
      end loop RassenSchleife;
      
      case
        VorhandeneRassen
      is
         when 0 =>
            -- Was mache ich denn in diesem Fall? Kann der überhaupt auftreten?
            return True;
            
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
            return True;
            
         when others =>
            return False;
      end case;
      
   end SiegBedingungEins;
   
   
   
   function SiegBedingungZwei
     return Boolean
   is begin
      
      RassenGeldSchleife:
      for RassenGeldSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           GlobaleVariablen.RassenImSpiel (RassenGeldSchleifenwert) = GlobaleDatentypen.Leer
         then
            null;
            
         elsif
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
            return True;
            
         else
            null;
         end if;
         
      end loop RassenGeldSchleife;
      
      return False;
      
   end SiegBedingungZwei;
   
   
   
   function SiegBedingungDrei
     return Boolean
   is begin
      
      case
        Cheat.GewonnenDurchCheat
      is
         when False =>
            return False;
            
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
            return True;
      end case;
         
   end SiegBedingungDrei;

end SiegBedingungen;
